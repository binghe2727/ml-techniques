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
	void constrcutNode(node * cn, vector<int> & dataIndex, const vector<vector<double>>& x, const vector<double>& ,int hgih);//high代表数的层数root节点为1,它的子节点为2,类推
	double routingFromNode(node * cn, vector<double> x);


	node * root;
	int featureSize;
	int dataSize;
	int ycate = 2;//y数值的种类
	int branch = 0;
	bool trained = false;
	int  treeHeight=-1;//完全生长的树
};




