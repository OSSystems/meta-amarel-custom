#!/usr/bin/python
import sys
import argparse
import os
import json
from pprint import pprint



default_server="192.168.20.145"
default_path= '/tmp'


def is_server_up(hostname):
    response = os.system("ping -c 1 " + hostname+" > /dev/null")
    #and then check the response...
    if response == 0:
        return True
    else:
        return False

def get_lastest_build(hostname,BuildType,download_dir):
    #download build information
    cmd = 'wget -q "http://%s:8111/guestAuth/app/rest/buildTypes/id:%s/builds" --header "Accept: application/json" -O builds.json'%(hostname,BuildType)
    os.system(cmd)
    with open('builds.json') as data_file:
        data = json.load(data_file)
        href=data["build"][0]["href"]
        cmd = 'wget -q "http://%s:8111%s/artifacts" --header "Accept: application/json" -O artifacts.json'%(hostname,href)
        os.system(cmd)
        with open('artifacts.json') as ar_data_file:
            ar_data = json.load(ar_data_file)
            count = ar_data["count"]
            for x in range(0,count):
                ar_href= ar_data["file"][x]["content"]["href"]
                cmd='wget  --directory-prefix=%s --progress=bar:force "http://%s:8111%s"'%(download_dir,hostname,ar_href)
                os.system(cmd)
  #  os.system("rm *.json")
##
def get_lastest_build_by_name_filter(hostname,BuildType,download_dir,name_filter):
    #download build information
    cmd = 'wget -q "http://%s:8111/guestAuth/app/rest/buildTypes/id:%s/builds" --header "Accept: application/json" -O builds.json'%(hostname,BuildType)
    os.system(cmd)
    with open('builds.json') as data_file:
        data = json.load(data_file)
        href=data["build"][0]["href"]
        cmd = 'wget -q "http://%s:8111%s/artifacts" --header "Accept: application/json" -O artifacts.json'%(hostname,href)
        os.system(cmd)
        with open('artifacts.json') as ar_data_file:
            ar_data = json.load(ar_data_file)
            count = ar_data["count"]
            for x in range(0,count):
		filename, fileext = os.path.splitext(ar_data["file"][x]["name"])
		if name_filter ==  fileext:
		  ar_href= ar_data["file"][x]["content"]["href"]
		  cmd='wget  --directory-prefix=%s --progress=bar:force "http://%s:8111%s"'%(download_dir,hostname,ar_href)
		  os.system(cmd)
  #  os.system("rm *.json")

##
def get_build_by_tag_filter(hostname,BuildType,download_dir,tag,name_filter):
    #download build information
    cmd = 'wget -q "http://%s:8111/guestAuth/app/rest/builds/buildType:%s,branch:default:any,tag:%s/artifacts" --header "Accept: application/json" -O builds.json > /dev/null '%(hostname,BuildType,tag)
    #print cmd
    os.system(cmd)
    found=True
    try:
        with open('builds.json') as data_file:
            data = json.load(data_file)
            count = data["count"]
            for x in range(0,count):
	      filename, fileext = os.path.splitext(data["file"][x]["name"])
	      if name_filter ==  fileext:
                href= data["file"][x]["content"]["href"]
                cmd='wget  --directory-prefix=%s --progress=bar:force "http://%s:8111%s" > /dev/null'%(download_dir,hostname,href)
		#print cmd
                os.system(cmd)
		
    except:
        found=False
    os.system("rm *.json")
    return found

def get_build_by_tag(hostname,BuildType,download_dir,tag):
    #download build information
    cmd = 'wget -q "http://%s:8111/guestAuth/app/rest/buildTypes/id:%s/builds" --header "Accept: application/json" -O builds.json'%(hostname,BuildType)


    os.system(cmd)
    found=False
    with open('builds.json') as data_file:
        data = json.load(data_file)
        count = data["count"]
        for x in range(0,count):
            href=data["build"][x]["href"]
            cmd = 'wget -q "http://%s:8111%s/" --header "Accept: application/json" -O builds.json'%(hostname,href)
            os.system(cmd)
            with open('builds.json') as bl_data_file:
                bl_data = json.load(bl_data_file)
                try:
                    if (bl_data["tags"]["tag"][0]["name"]==tag):
                        cmd = 'wget -q "http://%s:8111%s/artifacts" --header "Accept: application/json" -O artifacts.json'%(hostname,bl_data["href"])
                        os.system(cmd)
                        with open('artifacts.json') as ar_data_file:
                            ar_data = json.load(ar_data_file)
                            count = ar_data["count"]
                            for x in range(0,count):
                                ar_href= ar_data["file"][x]["content"]["href"]
                                cmd='wget  --directory-prefix=%s --progress=bar:force "http://%s:8111%s"'%(download_dir,hostname,ar_href)
                                os.system(cmd)

                        found=True
                        break

                except:
                    continue
    os.system("rm *.json")
    return found




def verify_buildType(hostname,project,buildType):
    #we download list of project and we make sure the project given to us is legall
    cmd = 'wget -q "http://%s:8111/guestAuth/app/rest/projects/%s" --header "Accept: application/json" -O projects.json'%(hostname,project)
    os.system(cmd)
    with open('projects.json') as data_file:
        data = json.load(data_file)
        count = data["buildTypes"]["count"]
        found=False
        out=""
        for x in range(0,count):
            if buildType==data["buildTypes"]["buildType"][x]["id"]:
                found=True
            out+= "\n"+data["buildTypes"]["buildType"][x]["id"] +" - "
            try:
                out+=data["buildTypes"]["buildType"][x]["description"]
            except:
                out+=data["buildTypes"]["buildType"][x]["name"]

        if not found:
            print "Build Type %s does not exist, aviliable projects are :"%buildType
            print out
            return False

    os.system("rm *.json")
    return True


def verify_project(hostname,project):
    #we download list of project and we make sure the project given to us is legall
    cmd = 'wget -q "http://%s:8111/guestAuth/app/rest/projects/" --header "Accept: application/json" -O projects.json'%hostname
    os.system(cmd)
    with open('projects.json') as data_file:
        data = json.load(data_file)
        count = data["count"]
        found=False
        out=""
        for x in range(1,count):
            if project==data["project"][x]["id"]:
                found=True
            out+= "\n"+data["project"][x]["id"] +" - "
            try:
                out+=data["project"][x]["description"]
            except:
                out+=data["project"][x]["name"]
        os.system("rm *.json")
        if not found:
            print "Project %s does not exist, aviliable projects are :"%project
            print out
            return False
    return True


def main(argv):

    global verbose
    global hostname
    global tag
    global config
    global name_filter

    parser=argparse.ArgumentParser()
    parser.add_argument("-v", "--verbose", help="increase output verbosity", action="store",dest="verbose")
    parser.add_argument("-s", "--server_address", help="Server Address where binaries are located ", action="store",dest="server")
    parser.add_argument("-t", "--tag", help="Artifacts Tag", action="store",dest="tag")
    parser.add_argument("-n", "--name_filter", help="Artifacts Name Filter", action="store",dest="name_filter")
    parser.add_argument("-p", "--project", help="CI Project Name", action="store",dest="project",required=True)
    parser.add_argument("-b", "--BuildType", help="Build Configuration", action="store",dest="BuildType",required=True)
    parser.add_argument("-d", "--download-dir", help="Downloaded Artifacts Path", action="store",dest="download_dir",required=True)
    

    args = parser.parse_args()
    #validate input
    #first check if we can contact server

    if args.server!=None:
        hostname=args.server
    else:
        hostname=default_server
    if is_server_up(hostname):
        print "server is up"
    else:
        print "Server "+hostname+" in not reachable...exiting"
        os._exit(1)




    #verify path exists
    if args.download_dir!=None:
        download_dir=args.download_dir
    else:
        download_dir=default_path
    if not os.path.exists(os.path.expanduser(download_dir)):
          print "Image download %s directory does not exist"%download_dir

    if not verify_project(hostname,args.project):
        print "Invalid Project Provided...exiting"
        os._exit(2)

    if not verify_buildType(hostname,args.project,args.BuildType):
        print "Invalid Project Provided...exiting"
        os._exit(3)
        
        
    if args.tag==None:
      if args.name_filter!=None:
	get_lastest_build_by_name_filter(hostname,args.BuildType,download_dir,args.name_filter)
      else:
	get_lastest_build(hostname,args.BuildType,download_dir)
    else:
      if args.tag=="latest":
	if args.name_filter!=None:
	  get_lastest_build_by_name_filter(hostname,args.BuildType,download_dir,args.name_filter)
	else:
	  get_lastest_build(hostname,args.BuildType,download_dir)
      else:
	if not get_build_by_tag_filter(hostname,args.BuildType,download_dir,args.tag,args.name_filter):
	  print "Tag does not exist...exiting"
	  os._exit(3)


if __name__ == "__main__":
    main(sys.argv[1:])


#scp ran@172.21.13.36:/home/ran/work_part/opx/upgrade_director/package/5.2.1.11825.local.bundle /ver


#wget --user=ran ftp://172.21.13.36/x
