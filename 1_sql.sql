declare
  l_date          date := sysdate;
  l_assignment_id per_all_assignments_f.assignment_id%type;
begin
  
  select paa.assignment_id
    into l_assignment_id
    from per_all_assignments_f paa
   where paa.person_id = (select paa.person_id
                            from per_all_assignments_f paa
                           where paa.assignment_id = 165087 --attribute1 из  hr_all_organization_units
                             and rownum = 1)
     and l_date between paa.effective_start_date and paa.effective_end_date
     and paa.assignment_status_type_id in (1, 3099);

  dbms_output.put_line('Актуальный assignment_id =  ' || l_assignment_id);
  
  exception
    when others then
      dbms_output.put_line(SQLCODE || ' ' ||SQLERRM );
end;