package kcg.system.t4_design_mng.svc;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import common.utils.common.CmmnMap;

@Service
public class Calculator {
	
    public static String addCommas(long number) {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(number);
    }
    
    public static String removeCommas(String number) {
        return number.replaceAll(",", "");
    }


	public List<CmmnMap> calculateSavings(CmmnMap params) { //적금
		return null;
	}

	public List<CmmnMap> calculateLump(CmmnMap params) { //목돈
		// TODO Auto-generated method stub
		return null;
	}

	public List<CmmnMap> calculateDeposit(CmmnMap params) { //예금

		List<CmmnMap> list = new ArrayList<>();
		
		String interestType = params.getString("interest_type");
		long subMoney = params.getLong("sub_money");
		double fInterestRate = params.getDouble("f_interest_rate");
		int fSelectMonth = params.getInt("f_select_month");
		double vInterestRate = params.getDouble("v_interest_rate");
		int vSelectMonth = params.getInt("v_select_month");
		
		if("단리".equals(interestType)){
			int length = fSelectMonth + vSelectMonth;
			long accumulateInterest = 0;
			long interest = Math.round(subMoney * fInterestRate);
			long roundTotal = 0;
			for(int i = 1; i <= length; i++ ){
				CmmnMap map = new CmmnMap();

				if(i <= fSelectMonth){
					accumulateInterest = accumulateInterest + interest;
					roundTotal = subMoney + accumulateInterest;
					map.put("round_num", i);
					map.put("round_sub_money", subMoney);
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);

				} else{
					interest = (long) (subMoney * vInterestRate);
					accumulateInterest = (long) (accumulateInterest + interest);
					roundTotal = subMoney + accumulateInterest;
					
					map.put("round_num", i);
					map.put("round_sub_money", subMoney);
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);
				}
			}
		}
		
		if("복리".equals(interestType)){

			int length = fSelectMonth + vSelectMonth;
			long accumulateInterest = 0;
			long roundTotal = subMoney;
			long interest = 0;
			for(int i = 1; i <= length; i++ ){
				CmmnMap map = new CmmnMap();

				if(i <= fSelectMonth){
					interest = (long) (roundTotal * fInterestRate); //회차당 이자
					accumulateInterest = (long) (accumulateInterest + (roundTotal * fInterestRate)); //누적이자
					roundTotal = (long) (subMoney + accumulateInterest); //회차당 누적되는 돈

					
					map.put("round_num", i);
					map.put("round_sub_money", subMoney);
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);
				} else{
					interest = Math.round(roundTotal * vInterestRate); //회차당 이자
					accumulateInterest = accumulateInterest + interest;
					roundTotal = (long) (subMoney + accumulateInterest); //회차당 누적되는 돈
					
					map.put("round_num", i); //회차
					map.put("round_sub_money", subMoney); //예치금
					map.put("round_interest", interest); //회차 이자
					map.put("acc_interest", accumulateInterest); //누적이자
					map.put("round_total", roundTotal); // 회차 총 금액
					list.add(map);

				}
			}

		}
		System.out.println("=================================================");
		System.out.println("=================================================");
		System.out.println("=================================================");
		System.out.println("=================================================");
		System.out.println("list: " + list.toString());
		return list;
		

	}

	public List<CmmnMap> calculateLoan(CmmnMap params) { //대출
		// TODO Auto-generated method stub
		return null;
	}

	
}
