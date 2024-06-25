package kcg.system.t4_design_mng.svc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import common.utils.common.CmmnMap;

@Service
public class Calculator {
	
    public static double SimpleInterest(double M, double r1, int n1, double r2, int n2, double T) {
        double totalPayment = 0;
        for (int i = 1; i <= n1; i++) {
            totalPayment += 1 / (1 + r1 * (n1 - i + 1) * (1 - T));
        }
        for (int i = 1; i <= n2; i++) {
            totalPayment += 1 / (1 + r2 * (n2 - i + 1) * (1 - T));
        }
        double PMT = M / totalPayment;
        return PMT;
    }

    public static double CompoundInterest(double M, double r1, int n1, double r2, int n2, double T) {
        double accumulatedAmount1 = 0;
        for (int i = 0; i < n1; i++) {
            accumulatedAmount1 += Math.pow(1 + r1 * (1 - T), n1 - i - 1);
        }

        double accumulatedAmount2 = 0;
        for (int i = 0; i < n2; i++) {
            accumulatedAmount2 += Math.pow(1 + r2 * (1 - T), n2 - i - 1);
        }

        double totalAccumulatedAmount = accumulatedAmount1 * (1 + r1 * (1 - T) * n1) + accumulatedAmount2 * (1 + r2 * (1 - T) * n2);
        double PMT = M / totalAccumulatedAmount;
        return PMT;
    }



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

        double simpleCycleMoney = SimpleInterest(subMoney, fInterestRate, fSelectMonth, vInterestRate, vSelectMonth, rate);
        double compoundCycleMoney = CompoundInterest(subMoney, fInterestRate, fSelectMonth, vInterestRate, vSelectMonth, rate);

		
		if("단리".equals(interestType)){
			long interest = 0;
			long accumulateInterest = 0;
			long cycleMoney = (long) simpleCycleMoney;
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
				
				long cycleMoney = (long) compoundCycleMoney;
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
		
		System.out.println("================서비스===============");
		System.out.println("params: " + params.toString());
		

		List<CmmnMap> list = new ArrayList<>();
		
		String loan_repayment_type = params.getString("loan_repayment_type");
		long subMoney = params.getLong("sub_money");
		double fInterestRate = params.getDouble("f_interest_rate");
		int fSelectMonth = params.getInt("f_select_month");
		double vInterestRate = params.getDouble("v_interest_rate");
		int vSelectMonth = params.getInt("v_select_month");
		int length = fSelectMonth + vSelectMonth;
		double rate = params.getDouble("rate");
		System.out.println("================서비스===============");
		System.out.println("문제있나:? ");
		
	    if(vInterestRate == 0 || vSelectMonth == 0){
	        if("원리금 균등".equals(loan_repayment_type) ) {
	        	long x = (long) (subMoney *fInterestRate /(Math.pow(1+fInterestRate, fSelectMonth)-1) + subMoney*fInterestRate);
	        	
	        	long accInterest = 0; //누적이자
	        	long roundInterest = 0; //회차 이자
	        	long roundPriCycleMoney = 0; //회차 원리금
	        	long roundTotal = 0; //잔금
        	
	        	for(int i = 1; i <= fSelectMonth; i++){
	        		
					CmmnMap map = new CmmnMap();
					
		        	roundInterest =(long) (subMoney * fInterestRate);
		        	accInterest = accInterest + roundInterest;
		        	roundPriCycleMoney = x - roundInterest;
		        	roundTotal = subMoney - roundPriCycleMoney;
		        	
		        	if(i == fSelectMonth){
		        		
						map.put("round_num", i);
						map.put("round_cycle_money",subMoney+roundInterest);
						map.put("round_pri_cycle_money", subMoney);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", 0);
						map.put("early_repayment_fee", (long) (roundTotal*rate*(length - i) /length));
						map.put("cycle_money", x);
						list.add(map);
		        	}else{
						map.put("round_num", i);
						map.put("round_cycle_money",x);
						map.put("round_pri_cycle_money", roundPriCycleMoney);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", roundTotal);
						map.put("early_repayment_fee", (long) (roundTotal*rate*(length - i) /length));
						
						subMoney = roundTotal;	
						list.add(map);
		        	}
	        	
	        	}	
	        }
	        if("원금 균등".equals(loan_repayment_type) ) {
	        	
	        	long a = subMoney / length;
	        	
	        	long accInterest = 0;
	        	long roundInterest = 0;
	        	long roundCycleMoney = 0;
	        	long roundTotal = 0;
	        	long accMoney = 0;
        	
	        	for(int i = 1; i <= fSelectMonth; i++){
	        		
					CmmnMap map = new CmmnMap();
	
		        	roundInterest = (long) (subMoney * fInterestRate);
		        	accInterest = accInterest + roundInterest;
		        	roundCycleMoney = a + roundInterest;
		        	roundTotal = subMoney - a;
		        	
	     			if(i == fSelectMonth){
						map.put("round_num", i);
						map.put("round_cycle_money",roundCycleMoney);
						map.put("round_pri_cycle_money", a);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", 0);
						map.put("early_repayment_fee", roundTotal*rate*(length - i) /length);
		
						list.add(map);
	     			}else{
						map.put("round_num", i);
						map.put("round_cycle_money",subMoney);
						map.put("round_pri_cycle_money", a);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", roundTotal);
						map.put("early_repayment_fee", roundTotal*rate*(length - i) /length);
						
						subMoney = roundTotal;	
						
						list.add(map);
	     			}

	        	}
	        	
	        }
	        
	        if("만기 일시".equals(loan_repayment_type) ) {
	        	long accInterest = 0;
	        	long roundInterest = 0;
	        	long roundPriCycleMoney = 0;
        	
	        	for(int i = 1; i <= fSelectMonth; i++){
	        		
					CmmnMap map = new CmmnMap();
	     			roundInterest =(long) (subMoney * fInterestRate);
	     			accInterest = accInterest + roundInterest;
	     			if(i == fSelectMonth){
	     				
	     				
						map.put("round_num", i);
						map.put("round_cycle_money",subMoney+roundInterest);
						map.put("round_pri_cycle_money", subMoney);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", 0);
						map.put("early_repayment_fee", (long) (subMoney*rate*(length - i) /length));
				
						list.add(map);

	     			}else{
						map.put("round_num", i);
						map.put("round_cycle_money",roundInterest);
						map.put("round_pri_cycle_money", 0);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", subMoney);
						map.put("early_repayment_fee", (long) (subMoney*rate*(length - i) /length));
				
						list.add(map);
	     				
	     			}
	     			
     			}
	    	
	        }
	    }else {	    	//여기가 고정금리일 때 if 문
	        if("원리금 균등".equals(loan_repayment_type) ) {
	    	
		        	long f = (long) ((Math.pow(1+fInterestRate , fSelectMonth) - 1)/fInterestRate);
		        	long v = (long) ((Math.pow(1+vInterestRate , vSelectMonth) - 1)/vInterestRate);
		        	
		        	long a = (long) ((subMoney + subMoney *vInterestRate *v - subMoney *fInterestRate *v)/(v + f + f*vInterestRate*v));
		        	long x = (long) (a + subMoney*fInterestRate);
	        	
		        	long accInterest = 0;
		        	long roundInterest = 0;
		        	long roundPriCycleMoney = 0;
		        	long roundTotal = 0;
	        	
		        	for(int i = 1; i <= fSelectMonth; i++){
						CmmnMap map = new CmmnMap();
		        		roundInterest =(long) (subMoney * fInterestRate);
		        		accInterest = accInterest + roundInterest;
		        		roundPriCycleMoney = x - roundInterest;
		        		roundTotal = subMoney - roundPriCycleMoney;
	    				
						map.put("round_num", i);
						map.put("round_cycle_money",x);
						map.put("round_pri_cycle_money", roundPriCycleMoney);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", roundTotal);
						map.put("early_repayment_fee", (long) (roundTotal*rate*(length - i) /length));
						
						subMoney = roundTotal;
						
						list.add(map);
		        	}
		        	
			        for(int i = 1; i <= vSelectMonth; i++){
						CmmnMap map = new CmmnMap();
		        		roundInterest =(long) (subMoney * vInterestRate);
		        		accInterest = accInterest + roundInterest;
		        		roundPriCycleMoney = x - roundInterest;
		        		roundTotal = subMoney - roundPriCycleMoney;

	        			if(i == vSelectMonth) {
	        				
							map.put("round_num", i+fSelectMonth);
							map.put("round_cycle_money",subMoney + roundInterest);
							map.put("round_pri_cycle_money", subMoney);
							map.put("round_interest", roundInterest);
							map.put("acc_interest", accInterest);
							map.put("round_total", 0);
							map.put("early_repayment_fee", 0);
							map.put("cycle_money", x);
							subMoney = roundTotal;
							
							list.add(map);
	        			}else{
	        				
							map.put("round_num", i+fSelectMonth);
							map.put("round_cycle_money",x);
							map.put("round_pri_cycle_money", roundPriCycleMoney);
							map.put("round_interest", roundInterest);
							map.put("acc_interest", accInterest);
							map.put("round_total", roundTotal);
				            map.put("early_repayment_fee", (long) (roundTotal * rate * (length - (i + fSelectMonth)) / length));
							
							subMoney = roundTotal;
							
							list.add(map);

	        			}
		        	}


		        }
	        if("원금 균등".equals(loan_repayment_type) ) {
		    	
		        	long a = subMoney / length;
		        	
		        	long accInterest = 0;
		        	long roundInterest = 0;
		        	long roundCycleMoney = 0;
		        	long roundPriCycleMoney = a;
		        	long roundTotal = 0;
		        	
	        	
		        	for(int i = 1; i <= fSelectMonth; i++){
						CmmnMap map = new CmmnMap();
		        		roundInterest =(long) (subMoney * fInterestRate);
		        		accInterest = accInterest + roundInterest;
		        		roundCycleMoney = a + roundInterest;
		        		roundTotal = subMoney - roundPriCycleMoney;
        				
						map.put("round_num", i);
						map.put("round_cycle_money",roundCycleMoney);
						map.put("round_pri_cycle_money", roundPriCycleMoney);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", roundTotal);
						map.put("early_repayment_fee", (long) (roundTotal*rate*(length - (i+fSelectMonth)/length)));
						
						
						subMoney = roundTotal;
						
						list.add(map);

		        	}
		        	for(int i = 1; i <= vSelectMonth; i++){
						CmmnMap map = new CmmnMap();
		        		roundInterest = (long) (subMoney * vInterestRate);
		        		accInterest = accInterest + roundInterest;
		        		roundCycleMoney = a + roundInterest;
		        		roundTotal = subMoney - a;
	        			
		        		if(i == vSelectMonth) {
							map.put("round_num", i+fSelectMonth);
							map.put("round_cycle_money",subMoney+roundCycleMoney);
							map.put("round_pri_cycle_money", subMoney);
							map.put("round_interest", roundInterest);
							map.put("acc_interest", accInterest);
							map.put("round_total", 0);
							map.put("early_repayment_fee",0);

							list.add(map);
							
		        		}else{
							map.put("round_num", i+fSelectMonth);
							map.put("round_cycle_money",roundCycleMoney);
							map.put("round_pri_cycle_money", roundPriCycleMoney);
							map.put("round_interest", roundInterest);
							map.put("acc_interest", accInterest);
							map.put("round_total", roundTotal);
							map.put("early_repayment_fee", (long) (roundTotal*rate*(length - (i+fSelectMonth)/length)));
			        
							subMoney = roundTotal;	
							list.add(map);
		        			
		        		}
		        			
		        			
		        	}

		       	} //원금균등까지
		        
	        if("만기 일시".equals(loan_repayment_type) ) {
	        	
		        	long accInterest = 0;
		        	long roundInterest = 0;
		        	long roundPriCycleMoney = 0;
	        	
		        	for(int i = 1; i <= fSelectMonth; i++){
						CmmnMap map = new CmmnMap();
		        		roundInterest =(long) (subMoney * fInterestRate);
		        		accInterest = accInterest + roundInterest;
        				
						map.put("round_num", i);
						map.put("round_cycle_money",roundInterest);
						map.put("round_pri_cycle_money", 0);
						map.put("round_interest", roundInterest);
						map.put("acc_interest", accInterest);
						map.put("round_total", subMoney);
						map.put("early_repayment_fee", (long) (subMoney*rate*(length - (i+fSelectMonth)/length)));
		        
						list.add(map);

		        	}
		        	
		        	for(int i = 1; i <= vSelectMonth; i++){
						CmmnMap map = new CmmnMap();
		        		roundInterest =(long) (subMoney * vInterestRate);
		        		accInterest = accInterest + roundInterest;

		        			if(i == vSelectMonth) {
								map.put("round_num", i+fSelectMonth);
								map.put("round_cycle_money",subMoney + roundInterest);
								map.put("round_pri_cycle_money", subMoney);
								map.put("round_interest", roundInterest);
								map.put("acc_interest", accInterest);
								map.put("round_total", 0);
								map.put("early_repayment_fee", (long) (subMoney*rate*(length - (i+fSelectMonth)/length)));
				        
								list.add(map);
		        				
		        			}else{
		        				
								map.put("round_num", i+fSelectMonth);
								map.put("round_cycle_money", roundInterest);
								map.put("round_pri_cycle_money", 0);
								map.put("round_interest", roundInterest);
								map.put("acc_interest", accInterest);
								map.put("round_total", subMoney);
								map.put("early_repayment_fee", (long) (subMoney*rate*(length - (i+fSelectMonth)/length)));
				        
								list.add(map);
		        				
		        			}
			        	}
		        	

		        } //만기일시까지 끝
	    
	    } //변동금리 적용 else부분 
	    

	    return list;
		        
	} //여기가 대출
	
}