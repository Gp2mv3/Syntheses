fun {Calculate N}
   case N of 1 then 1
   else {Calculate N-1} + {Calculate N-1} * {Calculate N-1}
   end
end