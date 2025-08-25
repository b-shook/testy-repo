select category.name as category_name
     , sum(case category.category_id when driver.first_choice then 1 else 0 end)  as first_choice
     , sum(case category.category_id when driver.second_choice then 1 else 0 end) as second_choice
     , sum(case category.category_id when driver.third_choice then 1 else 0 end)  as third_choice
  from category
     , ( select customer_id
              , max(case category_rank when 1 then category_id else null end)
              , max(case category_rank when 2 then category_id else null end)
              , max(case category_rank when 3 then category_id else null end)
           from customer_rental_preference
          group
             by customer_id
       ) as driver (customer_id, first_choice, second_choice, third_choice)
 group
    by category.name 
 order
    by 2 desc, 3 desc, 4 desc, 1;
