SELECT TOP 100
ba.fiserv_accountid,
ba.fiserv_accountnumber,
ba.fiserv_accounttype,
ba.fiserv_averagebalanceytd,
ba.fiserv_bank,
ba.fiserv_bankaccounthhid,
ba.fiserv_bankaccountsid,
ba.fiserv_branch,
ba.fiserv_currentbalance,
ba.fiserv_dateaccountclosed,
ba.fiserv_dateaccountopened,
ba.fiserv_dateaccountrenewed,
ba.fiserv_lasttransactiondate,
ba.fiserv_name,
ba.fiserv_name1,
ba.fiserv_officer,
ba.fiserv_officernumber,
ba.fiserv_productdescription,
ba.fiserv_service,
ba.fiserv_servicecategory,
ba.fiserv_socialsecuritynumberortaxid,
ba.modifiedon,
ba.ownerid,
UB.FullName AS ownerusername,
ba.wtfiserv_aasxaaaccountindicator,
ba.wtfiserv_acbsfacilitynumber,
ba.wtfiserv_assxaatype,
ba.wtfiserv_balancepreviousmonthend,
ba.wtfiserv_branchname,
ba.wtfiserv_dateaccountopenedoverride,
ba.wtfiserv_dateaccountopenedoverrideapprovaldate,
ba.wtfiserv_dateaccountopenedoverrideapprover,
ba.wtfiserv_fissecondaryofficername,
ba.wtfiserv_fissecondaryofficernumber,
ba.wtfiserv_inoutassessmentarea,
ba.wtfiserv_lastdepositdate,
ba.wtfiserv_lastdepositdolaramount,
ba.wtfiserv_laststatementendingdolarbalance,
ba.wtfiserv_loancommitmentpreviousmonthend,
SM1.Value AS wtfiserv_lowtomodorminority,
ba.wtfiserv_nameofcharter,
ba.wtfiserv_officernamepreviousmonthend,
ba.wtfiserv_officernumberpreviousmonthend,
ba.wtfiserv_previousmonthsenddate,
ba.wtfiserv_propertyaddressline1,
ba.wtfiserv_propertyaddressline2,
ba.wtfiserv_propertycity,
ba.wtfiserv_propertystate,
ba.wtfiserv_propertyzip,
SM2.Value AS wtfiserv_sensitivecustomer,
ba.wtfiserv_totalloans
FROM fiserv_bankaccountbase ba
JOIN fiserv_customeraccountrelationshipbase car on car.fiserv_parentbankaccountid=ba.fiserv_bankaccountid
FULL OUTER JOIN StringMap (NOLOCK) AS SM1 ON SM1.AttributeValue = Ba.wtfiserv_lowtomodorminority AND SM1.ObjectTypeCode=10005 AnD SM1.AttributeName = 'wtfiserv_lowtomodorminority'
FULL OUTER JOIN StringMap (NOLOCK) AS SM2 ON SM2.AttributeValue = Ba.wtfiserv_sensitivecustomer AND SM2.ObjectTypeCode=10005 AnD SM2.AttributeName = 'wtfiserv_sensitivecustomer'
FULL OUTER JOIN SystemUserBase (NOLOCK) UB on BA.OwnerId= UB.SystemUserId AND BA.OwnerIdType = 8
WHERE ba.StateCode=0 AND
car.fiserv_parentprofileid IN
(
SELECT contactid FROM contactbase CB WHERE  CB.StateCode=0 AND CB.parentcustomerid IS NULL
AND (CB.fiserv_profiletype =2 OR (CB.fiserv_profiletype =1 AND CB.modifiedon>'1/1/2018'))
AND (CB.OwnerIdType=9 OR (CB.OwnerIdType=8 and UB.fiserv_lineofbusinessindicator in (3,28,15,14,19,16,12,10)))
)


