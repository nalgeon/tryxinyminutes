# add in main
cd /tmp && mkdir repo && cd repo
git init >/dev/null 2>&1
echo "git is awesom" > message.txt
git add message.txt >/dev/null 2>&1
git commit -m "add message" >/dev/null 2>&1

# add in ohmypy
git branch ohmypy >/dev/null 2>&1
git switch ohmypy >/dev/null 2>&1
echo "print('git is awesome')" > ohmy.py
git add ohmy.py >/dev/null 2>&1
git commit -m "ohmy.py" >/dev/null 2>&1
echo "echo 'git is awesome'" > ohmy.sh
git add ohmy.sh >/dev/null 2>&1
git commit -m "ohmy.sh" >/dev/null 2>&1
echo "print('git is awesome')" > ohmy.lua
git add ohmy.lua >/dev/null 2>&1
git commit -m "ohmy.lua" >/dev/null 2>&1

# edit in main
git switch main >/dev/null 2>&1
echo "git is awesome" > message.txt
git commit -am "edit message" >/dev/null 2>&1

##CODE##