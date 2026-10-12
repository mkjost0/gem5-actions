git branch -r | grep -v '\->' | while read remote; do
    git branch --track "${remote#origin/}" "$remote";
done

for i in $(git branch | grep -vE "HEAD|stable"); do
    git checkout $i; git pull;
done
git checkout stable
git pull
git push -f --mirror origin
