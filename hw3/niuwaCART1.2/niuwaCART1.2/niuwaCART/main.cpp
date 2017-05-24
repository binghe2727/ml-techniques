#include "niuwaCART.h"
#include "niuwaRF.h"
#include "time.h"
using namespace std;

void main()
{

	niuwaCART * nc = new niuwaCART(-1);
	vector<vector<double>> x;
	vector<double> y;
	nc->readData("E://ML//Taiwan_ML//skill//homework3//hw3_train.dat",x,y);

	vector<vector<double>> x2;
	vector<double> y2;
	nc->readData("E://ML//Taiwan_ML//skill//homework3//hw3_test.dat", x2, y2);


	////13
	//nc->train(x,y);
	//vector<double> res=nc->predict(x);

	//double errRate = niuwaCART::errRate(y,res);
	//

	//vector<double> res2 = nc->predict(x);
	//
	//errRate = niuwaCART::errRate(y2, res2);
	//



	//16
	//clock_t start, finish;
	//start = clock();
	//double errRate = 0;
	//double errRate1 = 0;
	//double errRate2 = 0;
	//cout << "start:  " <<start<< endl;
	//for (int i = 0; i < 100;i++)
	//{
	//	niuwaRF * forest = new niuwaRF(300,1);
	//	forest->train(x, y);
	//	vector<double> res = forest->predict(x);
	//	vector<double> res2 = forest->predict(x2);
	//	double cerr=niuwaCART::errRate(y, res);
	//	double cerr1 = forest->errGt(x, y);
	//	double cerr2 = niuwaCART::errRate(y2, res2);
	//	cout << i + 1 << " " << cerr <<" "<<cerr1<<" "<<cerr2<<endl;
	//	errRate += cerr;
	//	errRate1 += cerr1;
	//	errRate2 += cerr2;
	//}
	//finish = clock();
	//cout << "finish:  " << finish << endl;
	//cout << "time:  " << (finish - start)/3600 << endl;
	//cout << errRate / 100 <<" "<<errRate1/100<<" "<<errRate2/100<<endl;

	


	clock_t start, finish;
	start = clock();
	double errRate = 0;
	//double errRate1 = 0;
	double errRate2 = 0;
	cout << "start:  " << start << endl;

	srand(time(0));
	for (int i = 0; i < 100; i++)
	{
		niuwaRF * forest = new niuwaRF(300, 1,2);
		forest->train(x, y);
		vector<double> res = forest->predict(x);
		//for (int j = 0; j < res.size(); j++)
		//	cout << res[j] << endl;

		

		vector<double> res2 = forest->predict(x2);
		double cerr = niuwaCART::errRate(y, res);
		//double cerr1 = forest->errGt(x, y);
		double cerr2 = niuwaCART::errRate(y2, res2);
		cout << i + 1 << " " << cerr /*<< " " << cerr1*/ << " " << cerr2 << endl;
		errRate += cerr;
		//errRate1 += cerr1;
		errRate2 += cerr2;
	}
	finish = clock();
	cout << "finish:  " << finish << endl;
	cout << "time:  " << (finish - start) / 3600 << endl;
,	cout << errRate / 100 << " " /*<< errRate1 / 100 */<< " " << errRate2 / 100 << endl;

	return;

}