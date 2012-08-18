#!/bin/bash
mysqldump --user=root --password=specright1707 --all-databases > specright_mysql_db_backup.sql
tar zcvf specright_mysql_db_backup.tar.gz specright_mysql_db_backup.sql
NOW=$(date +"%d-%m-%Y")
(uuencode specright_mysql_db_backup.tar.gz specright_mysql_db_backup_$NOW.tar.gz) | mailx -s "Specright Database Back Up $NOW" abauckland@gmail.com
rm specright_mysql_db_backup.sql
rm specright_mysql_db_backup.tar.gz
