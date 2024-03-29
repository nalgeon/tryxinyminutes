# bare repo
git init --bare /tmp/remote.git >/dev/null 2>&1

# sandbox repo
git clone /tmp/remote.git /tmp/repo >/dev/null 2>&1
cd /tmp/repo
echo "git is awesom" > message.txt
git add message.txt >/dev/null 2>&1
git commit -m "add message" >/dev/null 2>&1
git tag v1.0 HEAD
echo "git is awesome" > message.txt
git commit -am "edit message" >/dev/null 2>&1
git push >/dev/null 2>&1
git push --tags >/dev/null 2>&1

# alice repo
git clone /tmp/remote.git /tmp/alice >/dev/null 2>&1
cd /tmp/alice
git config user.email alice@example.com
git config user.name alice
echo "go is great" >> message.txt
git commit -am "go is great" >/dev/null 2>&1
echo "there is nothing to debate" >> message.txt
git commit -am "no debates" >/dev/null 2>&1
git push >/dev/null 2>&1

# bob repo
git clone /tmp/remote.git /tmp/bob >/dev/null 2>&1
cd /tmp/bob
git config user.email bob@example.com
git config user.name bob
echo "print('git is awesome')" > ohmy.py
git add ohmy.py >/dev/null 2>&1
git commit -m "ohmy.py" >/dev/null 2>&1
echo "echo 'git is awesome'" > ohmy.sh
git add ohmy.sh >/dev/null 2>&1
git commit -m "ohmy.sh" >/dev/null 2>&1
echo "print('git is awesome')" > ohmy.lua
git add ohmy.lua >/dev/null 2>&1
git commit -m "ohmy.lua" >/dev/null 2>&1
git push >/dev/null 2>&1

# back to sandbox repo
cd /tmp/repo
git pull >/dev/null 2>&1

##CODE##