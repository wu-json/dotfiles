function github_clean
    git checkout main
    git branch | grep -v main | xargs git branch -D
    git pull
    git reset --hard
    git clean -fd
end
