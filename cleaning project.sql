/****** Script for SelectTopNRows command from SSMS  ******/
-- Nashville Housing Dataset cleaning project 


--------------------------------------
--change the data types in order to make each column have consistent data



SELECT *
  FROM [portfolio II].[dbo].[Nashville]

select*-- saledate,convert(date, SaleDate) As ConvertedSaleDate
FROM [portfolio II].[dbo].[Nashville]

update Nashville
set SaleDateConverted = convert(date, SaleDate)


ALTER TABLE Nashville
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


-------------------------------------------------------------------------------
-- in the column SoldAsVacant the data isn't consistent too

select  distinct soldASVacant
from [portfolio II]..[Nashville]
group by SoldAsVacant



select soldAsVacant ,
case when soldAsVacant = 'N' then 'NO'
     when SoldAsVacant = 'Y' then 'Yes'
	 else SoldAsVacant
End

from [portfolio II]..[Nashville]


update Nashville
set 
SoldAsVacant = case when soldAsVacant = 'NO' then 'No'
     when SoldAsVacant = 'Y' then 'Yes'
	 else SoldAsVacant
End
from [portfolio II]..[Nashville]


-----------------------------------------------------------------
--some null data can be found if the costmer had another property

Select n.ParcelID , N.PropertyAddress, an.ParcelID ,
	  aN.PropertyAddress,
	  ISNULL(n.PropertyAddress,an.PropertyAddress) as ThePropertyAddress
	  
FROM [portfolio II].[dbo].[Nashville] N
join [portfolio II].[dbo].[Nashville] AN
on N.ParcelID = an.ParcelID
and n.UniqueID <> an.[UniqueID ]
where n.PropertyAddress is null


UPDATE N 
SET PropertyAddress = ISNULL(n.PropertyAddress,an.PropertyAddress)
FROM [portfolio II].[dbo].[Nashville] N
join [portfolio II].[dbo].[Nashville] AN
on N.ParcelID = an.ParcelID
and n.UniqueID <> an.[UniqueID ]
where n.PropertyAddress is null

------------------------------------------------------------
--seperate the address into two columns the CitySeperated and AddressSeperared

SELECT PropertyAddress
FROM [portfolio II].[dbo].[Nashville] N

SELECT 
SUBSTRING(n.PropertyAddress, 1 , CHARINDEX( ',' ,propertyAddress)-1) as address,
SUBSTRING(n.PropertyAddress , CHARINDEX( ',' ,propertyAddress)+1 , len(propertyAddress)) as 'city'
FROM [portfolio II].[dbo].[Nashville] N
 

 
ALTER TABLE [portfolio II].[dbo].[Nashville] 
Add addressSeparated varchar(255) ;

update [portfolio II].[dbo].[Nashville]
SET addressSeparated = SUBSTRING(PropertyAddress, 1 , CHARINDEX( ',' ,propertyAddress)-1) 


alter Table [portfolio II].[dbo].[Nashville]
ADD CitySeperated Varchar(255);

update [portfolio II].[dbo].[Nashville]
set CitySeperated = SUBSTRING(PropertyAddress, CHARINDEX( ',' ,propertyAddress)+1 ,len(propertyAddress))



select *
FROM [portfolio II].. Nashville

-------------------------------------------------------
-- delete the unusable columns

select * 
from [portfolio II]..[Nashville]
where OwnerName is not null
alter table [portfolio II]..[Nashville]
drop column propertyAddress, SaleDate, taxDistrict,ownerAddress