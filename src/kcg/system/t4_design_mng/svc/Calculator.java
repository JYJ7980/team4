package kcg.system.t4_design_mng.svc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import common.utils.common.CmmnMap;

@Service
public class Calculator {


	public List<CmmnMap> calculateSavings(CmmnMap params) { //적금
		System.out.println("================서비스===============");
		System.out.println("params: " + params.toString());

		List<CmmnMap> list = new ArrayList<>();
		String interestType = params.getString("interest_type");
		long cycleMoney = params.getLong("cycle_money");
		double fInterestRate = params.getDouble("f_interest_rate");
		int fSelectMonth = params.getInt("f_select_month");
		double vInterestRate = params.getDouble("v_interest_rate");
		int vSelectMonth = params.getInt("v_select_month");
		System.out.println("================서비스===============");
		System.out.println("interestType: " + interestType);

		
		if("단리".equals(interestType)){
			long interest = 0;
			long accumulateInterest = 0;
			long roundTotal = 0;
			for(int i = 1; i <= fSelectMonth; i++ ){
				CmmnMap map = new CmmnMap();

				interest = (long) (cycleMoney * fInterestRate * i);
				accumulateInterest = accumulateInterest + interest;
				roundTotal = (cycleMoney * i + accumulateInterest);
				
				map.put("round_num", i);
				map.put("round_cycle_money", cycleMoney);
				map.put("round_acc_cycle_money", (cycleMoney*i));
				map.put("round_interest", interest);
				map.put("acc_interest", accumulateInterest);
				map.put("round_total", roundTotal);
				list.add(map);
			}
			for(int i = 1 ; i <= vSelectMonth ; i++) {
				CmmnMap map = new CmmnMap();
	
				interest = (long) (interest + cycleMoney * vInterestRate);
				accumulateInterest = accumulateInterest + interest;
				roundTotal = cycleMoney * (i+fSelectMonth) + accumulateInterest;
				
				map.put("round_num", (i+fSelectMonth));
				map.put("round_cycle_money", cycleMoney);
				map.put("round_acc_cycle_money", (cycleMoney*(i+fSelectMonth)));
				map.put("round_interest", interest);
				map.put("acc_interest", accumulateInterest);
				map.put("round_total", roundTotal);
				list.add(map);

			}
			
		}
		
		if("복리".equals(interestType)){
			long interest = 0;
			long accumulateInterest = 0;
			long roundTotal = 0;
			long preTotal = 0;
			for (int i = 1; i <= fSelectMonth; i++) {
				CmmnMap map = new CmmnMap();
			    roundTotal = (long) ((roundTotal + cycleMoney) * (1 + fInterestRate));
			    interest = roundTotal - preTotal - cycleMoney;
			    accumulateInterest = roundTotal - (cycleMoney * i);
	
			    
				map.put("round_num", i);
				map.put("round_cycle_money", cycleMoney);
				map.put("round_acc_cycle_money", cycleMoney*i);
				map.put("round_interest", interest);
				map.put("acc_interest", accumulateInterest);
				map.put("round_total", roundTotal);
				list.add(map);
				preTotal = roundTotal;
			}
			
			for (int i = 1; i <= vSelectMonth; i++) {
				CmmnMap map = new CmmnMap();

				roundTotal = (long) ((roundTotal + cycleMoney) * (1 + vInterestRate));
				interest = roundTotal - preTotal - cycleMoney;
				accumulateInterest = roundTotal - (cycleMoney * (i + fSelectMonth));

				map.put("round_num", (i+fSelectMonth));
				map.put("round_cycle_money", cycleMoney);
				map.put("round_acc_cycle_money", cycleMoney*(i+fSelectMonth));
				map.put("round_interest", interest);
				map.put("acc_interest", accumulateInterest);
				map.put("round_total", roundTotal);
				list.add(map);
				preTotal = roundTotal;

			}			
		}
		return list;
	}

	public List<CmmnMap> calculateLump(CmmnMap params) { //목돈
		System.out.println("================서비스===============");
		System.out.println("params: " + params.toString());
		
		List<CmmnMap> list = new ArrayList<>();
		
		String interestType = params.getString("interest_type");
		long subMoney = params.getLong("sub_money");
		double fInterestRate = params.getDouble("f_interest_rate");
		int fSelectMonth = params.getInt("f_select_month");
		double vInterestRate = params.getDouble("v_interest_rate");
		double rate = params.getDouble("rate");
		int vSelectMonth = params.getInt("v_select_month");

		if("단리".equals(interestType)){
			long interest = 0;
			long accumulateInterest = 0;
			long fDenominator = (long) (fSelectMonth + fInterestRate * fSelectMonth *(fSelectMonth+1)/2 * (1-rate));
			long vDenominator = (long) (vSelectMonth + vInterestRate * vSelectMonth *(vSelectMonth+1)/2 * (1-rate));
			long denominator = vDenominator + fDenominator;
			long cycleMoney = (subMoney/denominator);
			long roundTotal = 0;
			
				for(int i = 1; i <= fSelectMonth; i++ ){
					CmmnMap map = new CmmnMap();

					interest = (long) (cycleMoney * fInterestRate * i);
					accumulateInterest = accumulateInterest + interest;
					roundTotal = cycleMoney * i + accumulateInterest;
					
					map.put("round_num", i);
					map.put("round_cycle_money", cycleMoney);
					map.put("round_acc_cycle_money", cycleMoney*i);
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);
				}
				
				for(int i = 1 ; i <= vSelectMonth ; i++) {
					CmmnMap map = new CmmnMap();
					interest = (long) (interest + cycleMoney * vInterestRate);
					accumulateInterest = accumulateInterest + interest;
					roundTotal = cycleMoney * (i+fSelectMonth) + accumulateInterest;

					map.put("round_num", (i+fSelectMonth));
					map.put("round_cycle_money", cycleMoney);
					map.put("round_acc_cycle_money", cycleMoney*(i+fSelectMonth));
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);

				}

		}
		
		if("복리".equals(interestType)){
						
				long denominator = 0;
				if(vSelectMonth != 0 || vInterestRate != 0 ) {
				denominator = (long) ((fSelectMonth + vSelectMonth -(1-rate)*(fSelectMonth + vSelectMonth) +
						 			(1+vInterestRate)*(Math.pow(1+vInterestRate, vSelectMonth) -1)/vInterestRate * (1-rate)) +
						 			((1+fInterestRate) *(Math.pow(1+fInterestRate, fSelectMonth)-1)/fInterestRate * 
						 			Math.pow(1+vInterestRate , vSelectMonth) * (1-rate)));
				} else {
			     denominator = (long) (fSelectMonth + (1 - rate) * 
		                      (((Math.pow(1 + fInterestRate, fSelectMonth) - 1) / fInterestRate) - fSelectMonth));
				}
				
				
				long cycleMoney = (subMoney / denominator);
				
				long preInterest = 0;
				long interest = 0;
		 		long roundTotal = 0;
				long accumulateInterest = 0;

				for (int i = 1; i <= fSelectMonth; i++) {
					CmmnMap map = new CmmnMap();
					roundTotal = (long) ((roundTotal + cycleMoney) * (1+fInterestRate));
					accumulateInterest = roundTotal - cycleMoney * i;
					interest = accumulateInterest - preInterest;
					
					map.put("round_num", i);
					map.put("round_cycle_money", cycleMoney);
					map.put("round_acc_cycle_money", cycleMoney*i);
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);
					preInterest = accumulateInterest;
				}
				for (int i = 1; i <= vSelectMonth; i++) {
					CmmnMap map = new CmmnMap();

					roundTotal = (long) ((roundTotal + cycleMoney) * (1 + vInterestRate));
					accumulateInterest = roundTotal - cycleMoney * (i + fSelectMonth);
					interest = accumulateInterest - preInterest;

					
					map.put("round_num", (i+fSelectMonth));
					map.put("round_cycle_money", cycleMoney);
					map.put("round_acc_cycle_money", cycleMoney*(i+fSelectMonth));
					map.put("round_interest", interest);
					map.put("acc_interest", accumulateInterest);
					map.put("round_total", roundTotal);
					list.add(map);
					preInterest = accumulateInterest;
				}

		}
		return list;
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