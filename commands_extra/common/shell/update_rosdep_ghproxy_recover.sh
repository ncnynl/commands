# rosdep recover script
# @author: ncnynl 
# @website: ncnynl.com 


# sources_list=~/tools/rosdep/old/sources_list.py
# init_url=~/tools/rosdep/old/__init__.py
# support_url=~/tools/rosdep/old/gbpdistro_support.py
# rep3_url=~/tools/rosdep/old/rep3.py
# github_url=~/tools/rosdep/old/github.py

# if  kinetic, melodic use python2.7 ; noetic(), foxy or newer use python3
# Tested 20.04 noetic
ros_version_0="/opt/ros/indigo"
ros_version_1="/opt/ros/kinetic"
ros_version_2="/opt/ros/melodic"

if [ -d $ros_version_0 ] ||  [ -d $ros_version_1 ] || [ -d $ros_version_2 ]; then
   echo "Your python version is python2.7"
   python_version="python2.7"
else 
   echo "Your python version is python3" 
   python_version="python3"
fi 

sources_list=/usr/lib/$python_version/dist-packages/rosdep2/sources_list.py
init_url=/usr/lib/$python_version/dist-packages/rosdistro/__init__.py
support_url=/usr/lib/$python_version/dist-packages/rosdep2/gbpdistro_support.py
rep3_url=/usr/lib/$python_version/dist-packages/rosdep2/rep3.py
github_url=/usr/lib/$python_version/dist-packages/rosdistro/manifest_provider/github.py

echo "recover $sources_list "
cp -r $sources_list"_bk" $sources_list
echo "recover $init_url "
cp -r $init_url"_bk" $init_url
echo "recover $support_url "
cp -r $support_url"_bk" $support_url
echo "recover $rep3_url "
cp -r $rep3_url"_bk" $rep3_url
echo "recover $github_url "
cp -r $github_url"_bk" $github_url
echo "all files is recovered , please run rosdep update  "