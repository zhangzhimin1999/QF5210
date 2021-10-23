jun_sep_sg=numeric(4)
jun_sep_uk=numeric(4)
jun_sep_us=numeric(4)
total_world_jun_sep=numeric(4)
jun_sep_sg[1:4]=c(sum(Jun_to_Sep_newcase_sg[1:30]),sum(Jun_to_Sep_newcase_sg[31:61]),sum(Jun_to_Sep_newcase_sg[62:93]),sum(Jun_to_Sep_newcase_sg[93:122]))
jun_sep_uk[1:4]=c(sum(Jun_to_Sep_newcase_uk[1:30]),sum(Jun_to_Sep_newcase_uk[31:61]),sum(Jun_to_Sep_newcase_uk[62:93]),sum(Jun_to_Sep_newcase_uk[93:122]))
jun_sep_us[1:4]=c(sum(Jun_to_Sep_newcase_us[1:30]),sum(Jun_to_Sep_newcase_us[31:61]),sum(Jun_to_Sep_newcase_us[62:93]),sum(Jun_to_Sep_newcase_us[93:122]))

oct_sg=sum(Oct_newcase_sg[1:16])
oct_uk=sum(Oct_newcase_uk[1:16])
oct_us=sum(Oct_newcase_us[1:16])

total_world_jun_sep[1:4]=six_nine_sg[1:4]+six_nine_uk[1:4]+six_nine_us[1:4]
total_world_oct=oct_sg+oct_uk+oct_us
