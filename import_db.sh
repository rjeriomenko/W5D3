#!/usr/bin/env sh

cat import_db.sql | sqlite3 board.db
sqlite3 board.db
