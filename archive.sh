#!/bin/sh
tar -czvf vimrc.tgz \
    --exclude='.git' \
    --exclude='*.DS_Store' \
    --exclude='.vim/user.vim*' \
    --exclude='.vim/tmp' \
    .vim/*
