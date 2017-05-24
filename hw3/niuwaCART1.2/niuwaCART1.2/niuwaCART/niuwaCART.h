#pragma once
#include <iostream>  
#include <fstream>  
#include <string>  
#include <vector>
using namespace std;
struct dataStruct
{
	vector<double> feature;
	double y;
};

struct node
{
	node * left;
	node * right;
	int i;
	int s;
	double theta;

};



class niuwaCART
{
public:
	niuwaCART(int);
	void readData(char * filename , vector<vector<double>>& x, vector<double>& y);
	void train(const vector<vector<double>>& x, const vector<double>& y);
	vector<double> predict( vector<vector<double>>);
	//int niuwaCompare(const void*a, const void*b);
	static bool doubleEqu(double a, double b);
	static double errRate(vector<double>, vector<double>);


	~niuwaCART();

private:



	void QuickSort(vector<int> & e, int first, int end, int featureIndex, const vector<vector<double>>& x);
	double binImpur(int * lYcount, int * rYcount);
	void constrcutNode(node * cn, vector<int> & dataIndex, const vector<vector<double>>& x, const vector<double>& ,int hgih);//high�������Ĳ���root�ڵ�Ϊ1,�����ӽڵ�Ϊ2,����
	double routingFromNode(node * cn, vector<double> x);


	node * root;
	int featureSize;
	int dataSize;
	int ycate = 2;//y��ֵ������
	int branch = 0;
	bool trained = false;
	int  treeHeight=-1;//��ȫ��������
};




