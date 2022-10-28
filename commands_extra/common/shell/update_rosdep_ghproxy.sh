# rosdep update script
# @author: ncnynl 
# @website: ncnynl.com 

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

ghproxy_url=https://ghproxy.com

sources_list=/usr/lib/$python_version/dist-packages/rosdep2/sources_list.py
init_url=/usr/lib/$python_version/dist-packages/rosdistro/__init__.py
support_url=/usr/lib/$python_version/dist-packages/rosdep2/gbpdistro_support.py
rep3_url=/usr/lib/$python_version/dist-packages/rosdep2/rep3.py
github_url=/usr/lib/$python_version/dist-packages/rosdistro/manifest_provider/github.py

# sources_list=~/tools/rosdep/old/sources_list.py
# init_url=~/tools/rosdep/old/__init__.py
# support_url=~/tools/rosdep/old/gbpdistro_support.py
# rep3_url=~/tools/rosdep/old/rep3.py
# github_url=~/tools/rosdep/old/github.py


echo "Looking for /usr/lib/$python_version/dist-packages/rosdep2/sources_list.py"

result=$(cat $sources_list | grep "$ghproxy_url")
echo $result

if [ "$result" != "" ]; then
    echo "You haved run, Don't need run again!"
    exit
fi

if [ -f $sources_list ]; then
   echo "Backup file $sources_list"
   cp -r $sources_list $sources_list"_bk"
   
   echo "replace to DEFAULT_INDEX_URL on line 72"
   sed -i 's/https:\/\/raw/https:\/\/ghproxy.com\/https:\/\/raw/g' $sources_list
   echo "replace to download_rosdep_data(source.url) on line 480"
   sed -i 's/download_rosdep_data(source.url)/download_rosdep_data("https:\/\/ghproxy.com\/"+source.url)/g' $sources_list
   echo "replace to download_gbpdistro_as_rosdep_data(source.url) on line 486"
   sed -i 's/download_gbpdistro_as_rosdep_data(source.url)/download_gbpdistro_as_rosdep_data("https:\/\/ghproxy.com\/"+source.url)/g' $sources_list

fi


echo "Looking for /usr/lib/$python_version/dist-packages/rosdistro/__init__.py"


if [ -f $init_url ]; then
   echo "Backup file $init_url"
   cp -r $init_url $init_url"_bk"
   echo "replace to DEFAULT_INDEX_URL on line 68"
   sed -i 's/https:\/\/raw/https:\/\/ghproxy.com\/https:\/\/raw/g' $init_url
fi


echo "Looking for /usr/lib/$python_version/dist-packages/rosdep2/gbpdistro_support.py"

if [ -f $support_url ]; then
   echo "Backup file $support_url"
   cp -r $support_url $support_url"_bk"
   echo "replace to FUERTE_GBPDISTRO_URL on line 36"
   sed -i 's/https:\/\/raw/https:\/\/ghproxy.com\/https:\/\/raw/g' $support_url
   echo "replace to FUERTE_GBPDISTRO_URL on line 36"
   
fi


echo "Looking for /usr/lib/$python_version/dist-packages/rosdep2/rep3.py"

if [ -f $rep3_url ]; then
   echo "Backup file $rep3_url"
   cp -r $rep3_url $rep3_url"_bk"
   echo "replace to REP3_TARGETS_URL on line 39"
   sed -i 's/https:\/\/raw/https:\/\/ghproxy.com\/https:\/\/raw/g' $rep3_url
fi


echo "Looking for /usr/lib/$python_version/dist-packages/rosdistro/manifest_provider/github.py"

if [ -f $github_url ]; then
   echo "Backup file $github_url"
   cp -r $github_url $github_url"_bk"
   echo "replace to url on line 68 and 119"
   sed -i 's/https:\/\/raw/https:\/\/ghproxy.com\/https:\/\/raw/g' $github_url
fi

echo "all files replaced is finished, please continues run rosdep update "
