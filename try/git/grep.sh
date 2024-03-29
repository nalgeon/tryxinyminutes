cd /tmp && mkdir repo && cd repo
git init > /dev/null 2>&1
echo "git is awesome" > message.txt
git add message.txt >/dev/null 2>&1
git commit -m "is awesome" >/dev/null 2>&1
echo "git is great" >> message.txt
git commit -am "is great" >/dev/null 2>&1
echo "there is nothing to debate" >> message.txt
git commit -am "no debates" >/dev/null 2>&1
##CODE##
