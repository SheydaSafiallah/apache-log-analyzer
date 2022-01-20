#!/bin/bash

clear

#We can get the number of results from the user -> read number then use number in front of head -n

function showMostVisitedURLs {
  awk -F\" '{print $2}' $log | awk '{print $2}' | sort | uniq -c | sort -rn | head -n 10

}


function showTopIPs {
    cat $log | awk '{print count "times {" $1 "} this IP is repeated."}' | sort | uniq -c  | sort -nr | head -n 10
}



function showPopularBrowsers {
    cat $log | awk '{count[$12]++} END {for (browser in count) print browser, count[browser]}' | sort -nr -k2 | head -n 10
}



function showTopReferences {
    cat $log | awk -F\" '{ print  $4 }'| grep -v '-'| sort | uniq -c | sort -nr | head -n 10
}



function showMostPopularOS {
    cat $log | awk '{count[$13]++} END {for (os in count) print os, count[os]}' | sort -nr -k2 | head -n 10
}


function showMostPopularUserAgent {
    awk '{print $12}' $log | sort | uniq -c | sort -rn | head -n 10
  }


function countRequestStatus {

  awk '{print $9}' $log | sort | uniq -c | sort -rn
}


function showLogsInParticularTimeRange {

  awk '/01:05:/,/01:20:/' $log
#  we can use variables to change time range
}


function sortByResponseSize {
 cat $log |awk '{print $10 " " $1 " " $4 " " $7}'|sort -nr|head -100
}


function menu {

while true
do
      echo menu:
      echo choose 1 to show top visited URLs
      echo choose 2 to show top IPs
      echo choose 3 to show top Browsers
      echo choose 4 to show top Refrence Addresses
      echo choose 5 to show top Operating Systems
      echo choose 6 to show top user agent
      echo choose 7 to count request status
      echo choose 8 to show logs in particular time range
      echo choose 9 to show logs by response size


      echo choose one of them:
      read selectedItem


      case $selectedItem in
        1) showMostVisitedURLs;;
        2) showTopIPs;;
        3) showPopularBrowsers;;
        4) showTopReferences;;
        5) showMostPopularOS;;
        6) showMostPopularUserAgent;;
        7) countRequestStatus;;
        8) showLogsInParticularTimeRange;;
        9) sortByResponseSize;;
        *) echo Invalid number;;
        esac
        done

}



function getFile {
  echo Please select the log file:
  read log
  menu
}

getFile