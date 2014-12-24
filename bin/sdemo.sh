#! bin/bash

function setup_project() {
    project_name=${PWD##*/}
    echo $project_name
    echo "当先项目名称为：$project_name"
    # validate
    if ! [[ $project_name =~ ^[a-z0-9]+$ ]]
    then
        echo '非法的项目名称，为了保证项目正常使用请使用小写字母'
        exit
    fi
    echo '开始替换文件中的项目名称'
    # Linux users should replace `sed -i ''` => `sed -i`
    # http://stackoverflow.com/questions/16745988/sed-command-works-fine-on-ubuntu-but-not-mac
    find . -type f ! -path './.*/*' ! -path 'node_modules' ! -name '.*' -print0 \
        | xargs -0 sed -i '' "s/\*|ProjectName|\*/$project_name/g"
    echo '生成项目文件'
    touch "src/$project_name.scss"
    touch "src/$project_name.coffee"
    echo 'Enjoy coding!'
}

if [ -a package.json ];
then
    setup_project
else
    read -p '输入项目名称（[a-z0-9]）：' project_name
    if [ -d $project_name ]
    then
       echo '[Error]该目录下已有同名项目，建议更换项目名称'
       exit
    fi
    echo '正在初始化项目结构'
    git clone git@github.com:Niandalu/sdemo.git $project_name
    cd $project_name
    setup_project
    break
fi
