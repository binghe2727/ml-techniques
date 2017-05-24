#pragma once
#include "niuwaCART.h"
#include <ctime>


class niuwaRF
{
public:
	niuwaRF();

	niuwaRF(int treeNums ,double dataScale,int high);//������Ŀ,ÿ����baggingʹ��data�ı���
	~niuwaRF();
	void train(const vector<vector<double>>& x, const vector<double>& y);
	vector<double> predict(vector<vector<double>>x);
	double errGt(vector<vector<double>>x,vector<double> y);

private:
	void bagging(const vector<vector<double>>& x, const vector<double>& y, vector<vector<double>>& xout, vector<double>& yout,double dataScale);

	int treeNums;
	double dataScale;
	niuwaCART * * forest;
	int treeHigh=-1;//-1Ϊû�и߶����� ��ȫ����
};

