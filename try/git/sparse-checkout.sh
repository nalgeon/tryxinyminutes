# bare repo
git init --bare /tmp/remote.git >/dev/null 2>&1

# sandbox repo
git clone /tmp/remote.git /tmp/repo >/dev/null 2>&1
cd /tmp/repo
touch go.mod main.go
mkdir users
touch users/users.go
mkdir products
touch products/products.go
git add . >/dev/null 2>&1
git commit -m "initial commit" >/dev/null 2>&1
git push >/dev/null 2>&1

# clean
rm -rf /tmp/repo
cd /tmp

##CODE##