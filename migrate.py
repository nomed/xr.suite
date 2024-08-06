import glob, os, xmltodict, json
from ruamel.yaml import YAML
yaml = YAML()
rp_yaml = yaml.load(open(".github/workflows/release-please.yaml").read())
rp_yaml
#poms = glob.glob('**/pom.xml', recursive=True)
artifacts = dict()
def parse_pom(pkg):
    pom = os.path.join('pkgs', pkg, 'pom.xml')
    xml = xmltodict.parse(open(pom).read())
    prj = xml["project"]
    return dict(groupId=prj["groupId"], 
                               artifactId=prj["artifactId"], 
                               version=prj["version"],
                               name=prj["name"])
    # 
    # pkg_dict = dict()
    # if prj["parent"]["artifactId"] in pkgs:
    #     pkg_dict["parent"] = prj["parent"]
    # else:
    #     pkg_dict["parent"] = None
    # pkg_dict["current"] = dict(groupId=prj["groupId"], 
    #                            artifactId=prj["artifactId"], 
    #                            version=prj["version"],
    #                            name=prj["name"])
    # pkg_dict["dep_man"] = []
    # for dep in prj["dependencyManagement"]["dependencies"]["dependency"]:
    #     if dep["artifactId"] in pkgs:
    #         pkg_dict["dep_man"].append(dep)
    
release_please = json.loads(open("release-please-config.json").read())
manifest = {} #json.loads(open(".release-please-manifest.json").read())
release_please["packages"] = {}
pkgs = []
for pkg in glob.glob("pkgs/*"):
    if os.path.isdir(pkg) and os.path.exists(f"{pkg}/pom.xml"):
        pkgs.append(os.path.basename(pkg))
        artifact = parse_pom(os.path.basename(pkg))
        artifacts[artifact["artifactId"]] = artifact["version"]
        key = f"{pkg}"
        release_please["packages"][key] = {"package-name": artifact["artifactId"],
                                                "release-type": "maven",
                                                "initial-version": artifact["version"],
                                                "skip-snapshot": True}
pomchk = dict()        
for pom in glob.glob("pkgs/*/pom.xml"):
    pom_xml = xmltodict.parse(open(pom).read())
    pom_xml
    prj = pom_xml["project"]
    pomchk[pom] = {}
    printed=False
    if "dependencies" in prj.keys() and "dependency" in prj["dependencies"]:
        if prj.get("parent") and prj["parent"]["artifactId"] in pkgs:
            artifact_id = prj["parent"]["artifactId"]
            version = prj["parent"]["version"]
            if artifact_id in artifacts:
                latest_version = artifacts[artifact_id]
                if not version.startswith("$") and version != latest_version:
                    if not printed:
                        print(f"{pom}")
                        printed=True
                    print(f"\t{artifact_id} {version} -> {latest_version}")
                    prj["parent"]["version"] = latest_version
                    pomchk[pom][artifact_id] = dict(current=version, latest=latest_version)
        for dep in prj["dependencies"]["dependency"]:
            if dep["artifactId"] in pkgs:
                artifact_id = dep["artifactId"]
                version = dep["version"]
                if artifact_id in artifacts:
                    latest_version = artifacts[artifact_id]
                    if not version.startswith("$") and version != latest_version:
                        if not printed:
                            print(f"{pom}")
                            printed=True
                        print(f"\t{artifact_id} {version} -> {latest_version}")
                        dep["version"] = latest_version
                        pomchk[pom][artifact_id] = dict(current=version, latest=latest_version)
        for prop, version in prj["properties"].items():
            name = prop.split(".version")
            if len(name) > 0 and name[0] in pkgs:
                artifact_id = name[0]
                if artifact_id in artifacts:
                    latest_version = artifacts[artifact_id]
                    if not version.startswith("$") and version != latest_version:
                        if not printed:
                            print(f"{pom}")
                            printed=True                        
                        print(f"\t{artifact_id} {version} -> {latest_version}")                        
                        pomchk[pom][artifact_id] = dict(current=version, latest=latest_version)

for pkg in artifacts:
    for sfx in ["tag-name", "release_created"]:
        pkg_out = f"{pkg}--{sfx}"
        if not pkg_out in rp_yaml["jobs"]["release-please"]["outputs"]:
            rp_yaml["jobs"]["release-please"]["outputs"][pkg_out] = "${{steps.release.outputs.%s}}"%pkg_out

if True:

    yaml.dump(rp_yaml, open(".github/workflows/release-please.yaml", "w"))
    json.dump(release_please, open("release-please-config.json", "w"), indent=2)
    release_please_manifest = dict()
    for p,v in artifacts.items():
        release_please_manifest[f"pkgs/{p}"] = v
    json.dump(release_please_manifest, open(".release-please-manifest.json", "w"), indent=2)
json.dump(pomchk, open("pomchk.json", "w"), indent=2)

#print(artifacts)
