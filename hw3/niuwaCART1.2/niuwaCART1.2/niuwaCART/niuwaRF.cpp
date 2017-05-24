#include "niuwaRF.h"



niuwaRF::niuwaRF()
{

}

niuwaRF::niuwaRF(int tn,double ds,int high)
{
	this->treeHigh = high;
	this->treeNums = tn;
	this->dataScale = ds;
	this->forest = new niuwaCART*[tn];
	for (int i = 0; i < tn; i++)
	{
		forest[i] = new niuwaCART(this->treeHigh);
	}
}
void niuwaRF::train(const vector<vector<double>>& x, const vector<double>& y)
{
	for (int i = 0; i < this->treeNums; i++)
	{
		vector<vector<double>> xn;
		vector<double> yn;
		this->bagging(x, y, xn, yn, this->dataScale);
		//for (int j = 0; j < xn.size(); j++)
		//{
		//	cout << xn[j][0] <<" "<< xn[j][1] << " " << yn[j] << " " << endl;
		//}


		this->forest[i]->train(xn, yn);
	}
}

vector<double> niuwaRF::predict(vector<vector<double>> x)
{
	
	vector<double> yout;
	for (int i = 0; i < x.size(); i++)
	{
		yout.push_back(0);
	}
	vector<double> cout;


	for (int j = 0; j < this->treeNums; j++)
	{
		cout= this->forest[j]->predict(x);
		for (int i = 0; i < x.size(); i++)
		{
			yout[i] += cout[i];
		}
	}
	

	for (int i = 0; i < x.size(); i++)
	{
		if (yout[i] > 0)
			yout[i] = 1;
		else
			yout[i] = -1;
	}

	return yout;
}

double niuwaRF::errGt(vector<vector<double>>x, vector<double> y)
{
	double errRate = 0;
	for (int i = 0; i < this->treeNums; i++)
	{
		vector<double> res = this->forest[i]->predict(x);
		errRate+=niuwaCART::errRate(res, y);
	}
	return errRate/this->treeNums;
}

void niuwaRF::bagging(const vector<vector<double>>& x, const vector<double>& y, vector<vector<double>>& xout, vector<double>& yout,double dataScale)
{
	if (dataScale > 1)
		exit(0);

	//srand(time(0));
	int dataCount = x.size()*dataScale;
	for (int i = 0; i < dataCount; i++)
	{
		
		int index = rand()%x.size();
		xout.push_back(x[index]);
		yout.push_back(y[index]);
	}

}





niuwaRF::~niuwaRF()
{
}
