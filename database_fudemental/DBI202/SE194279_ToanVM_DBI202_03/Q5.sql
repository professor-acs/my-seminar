
select pm.ModelID, pm.Name, count(p.Name) as 'NumberOfProducts'

from ProductModel pm
left join Product p on p.ModelID = pm.ModelID
group by  pm.ModelID, pm.Name
having pm.Name like 'Mountain%' or pm.Name like 'ML Mountain%'
order by count(p.Name) desc, pm.Name asc

