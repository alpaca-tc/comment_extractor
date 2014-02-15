/*[-1-] this is comment
[-2-]comemnt out[-end-]*/
select SessionSID
, TargetID
--[-5-], TargetName
, FEDSurveyName
, SupplierID
, ClientLK_ResponseStatusID
from BI_Sessions (nolock)
WHERE EntryDate BETWEEN '05-15-2012' AND '05-16-2012'
AND SupplierID = 336
