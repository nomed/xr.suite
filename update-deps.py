import subprocess
from xml.etree import ElementTree as et
import glob
import os
import xmltodict
import json

def parse_pom(pkg):
    pom = os.path.join('pkgs', pkg, 'pom.xml')
    xml = xmltodict.parse(open(pom).read())
    prj = xml["project"]
    return dict(groupId=prj["groupId"], 
                               artifactId=prj["artifactId"], 
                               version=prj["version"],
                               name=prj["name"])

def get_graph():
    artifacts = dict()
    pkgs = []
    for pkg in glob.glob("pkgs/*"):
        if os.path.isdir(pkg) and os.path.exists(f"{pkg}/pom.xml"):
            pkgs.append(os.path.basename(pkg))
            artifact = parse_pom(os.path.basename(pkg))
            artifacts[artifact["artifactId"]] = artifact["version"]
    return artifacts


def get_pom(pom_path, update=False):

    ns = "http://maven.apache.org/POM/4.0.0"
    et.register_namespace('', ns)
    tree = et.ElementTree()
    tree.parse(pom_path)
    return tree

def get_property_value(root, property_name, ns):
    properties = root.find('.//mvn:properties', ns)
    if properties is not None:
        property_value = properties.find(f'mvn:{property_name}', ns)
        if property_value is not None:
            return property_value
    return None

manifest = get_graph()
print(json.dumps(manifest, indent=2))

for pom_path in glob.glob("pkgs/**/pom.xml", recursive=True):
    commit = ""
    tree = get_pom(pom_path)
    ns = {'mvn': "http://maven.apache.org/POM/4.0.0"}
    root = tree.getroot()
    
    dependencies = root.findall('.//mvn:dependency', ns)
    parent = root.find('.//mvn:parent', ns)
    
    for dependency in dependencies + ([parent] if parent is not None else []):
        artifact = dependency.find('mvn:artifactId', ns)
        version = dependency.find('mvn:version', ns)
        
        if artifact is not None and version is not None and artifact.text in manifest:
            version_current = version.text
            if version_current.startswith('${') and version_current.endswith('}'):
                property_name = version.text[2:-1]   
                version = get_property_value(root, property_name, ns)
                version_current = version.text
            if version.text != manifest[artifact.text]:
                version_current = version.text
                version.text = manifest[artifact.text]
                print(f"{pom_path} {artifact.text} {version_current} -> {manifest[artifact.text]}")
                commit += "deps: update %s from %s to %s\n" % (artifact.text, version_current, manifest[artifact.text])
    print (commit)
    tree.write(pom_path, encoding='utf-8', xml_declaration=True)
    if commit :
        # Stage the file
        subprocess.run(["git", "add","-f", pom_path], check=True)
        # Commit the changes
        subprocess.run(["git", "commit", "-m", commit], check=True) 
 

    
   