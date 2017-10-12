require 'json'
require 'open-uri'

class LottoController < ApplicationController
   def index
    
  
    
    get_info = JSON.parse open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read

    drw_numbers = []
    get_info.each do |k, v|
      drw_numbers << v if k.include? 'drwtNo'
    end
    drw_numbers.sort!    

  my_numbers = (1..45).to_a.samples(6)

     match_numbers = my_numbers & drw_numbers
     match_cnt = match_numbers.count
     
     if match_cnt == 6
        result = "1등"
     elsif match_cnt == 5 && my_numbers.include?(bonus_number)
     result = "2등"
     elsif match_cnt ==5
         result ="3등"
    elsif match_cnt == 4
    result = "4등"
    elsif match_cnt == 3
    result = "3등"
else
    result = "꽝"
end
   
   @my_numbers = my_numbers
   @drw_numbers= drw_numbers
   @match_cnt = match_cnt
   @match_numbers = match_numbers
   @result = result
   end
 end