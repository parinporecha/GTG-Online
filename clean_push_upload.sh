find . -name '*.pyc' -print0 | xargs -0 rm -f
cp ./Inception/settings_for_dotcloud.py ./Inception/settings.py
git status
read -p ">>> Proceed to push the code to dotcloud ? " yn
if [ $yn = "y" ] || [ $yn = "Y" ] || [ $yn = "YES" ] || [ $yn = "yes" ] || [ $yn = "Yes" ]; then
    export https_proxy="http://proxy.iiit.ac.in:8080"
    dotcloud push
    export https_proxy="https://proxy.iiit.ac.in:8080"
else
    echo ">>>No problem, do it later !"
fi
read -p ">>> Enter git commands: " command
while [ "$command" != "done" ] && [ "$command" != "Done" ] && [ "$command" != "DONE" ]
do
    $command
    read -p ">>> Enter git commands: " command
    git status
done
read -p ">>> Enter commit message: " commit_msg
git commit -m $commit_msg
git push origin master
cp ./Inception/settings_for_localhost.py ./Inception/settings.py
