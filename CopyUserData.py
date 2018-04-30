import sys, os
import shutil
args = sys.argv

def print_usage():
    print "./CopyUserData source_user_name destination_user_name"

if len(args) == 1:
    print_usage()
    sys.exit(-1)

if (args[1] == 'help'):
    print_usage()
    sys.exit(0)

path = os.path.dirname(sys.argv[0])
abs_path = os.path.abspath(path)

xcodeproj_path = os.path.join(abs_path, 'App', 'Solar System.xcodeproj')

workspace_data_path = os.path.join(xcodeproj_path, 'project.xcworkspace', 'xcuserdata')
base_data_path = os.path.join(xcodeproj_path, 'xcuserdata')

source_username = args[1]
dest_username = args[2]
source_folder_name = source_username + ".xcuserdatad"
dest_folder_name = dest_username + ".xcuserdatad"

workspace_dest_dir = os.path.join(workspace_data_path, dest_folder_name)
base_dest_dir = os.path.join(base_data_path, dest_folder_name)

if os.path.exists(workspace_dest_dir):
    shutil.rmtree(workspace_dest_dir)
if os.path.exists(base_dest_dir):
    shutil.rmtree(base_dest_dir)

shutil.copytree(os.path.join(workspace_data_path, source_folder_name), workspace_dest_dir)
shutil.copytree(os.path.join(base_data_path, source_folder_name), base_dest_dir)

print "Success"
