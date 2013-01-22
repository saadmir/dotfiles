#!/bin/bash

hostname=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`

xml="<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">
  <soap12:Body>
    <updateRecord xmlns=\"http://powerdns.net/express\">
      <recordId>${recordid}</recordId>
      <Name>${cname}</Name>
      <Type>CNAME</Type>
      <Content>${hostname}</Content>
      <TimeToLive>60</TimeToLive>
      <Priority>0</Priority>
    </updateRecord>
  </soap12:Body>
</soap12:Envelope>"

url="https://www.powerdns.net/services/express.asmx?apikey=${apikey}" 

header="Content-Type: text/xml; charset=utf-8"

curl -s -H "${header}" -d "${xml}" "${url}" > /opt/update_powerdns_net/update_powerdns_net.out

