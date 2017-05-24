#include "niuwaCART.h"


niuwaCART::niuwaCART(int high=-1)
{
	this->treeHeight = high;
}

void  niuwaCART::readData(char * filename, vector<vector<double>>& x, vector<double>& y)
{
	x.clear();
	y.clear();
	ifstream myfile;
	myfile.open(filename);
	string str;
	/*int dataSize = 1;
	int featureSize = 0;*/
	int startpos;

	if (getline(myfile, str))
	{
		while ((startpos = str.find(' ', 0)) != -1)
		{
			featureSize++;
			str = str.substr(startpos + 1);
		}
	}
	while (getline(myfile, str))
	{
		dataSize++;
	}

	/*y = new int[dataSize];
	x = new double*[dataSize];*/

	//for (int i = 0; i < dataSize; i++)
	//{
	//	vector<float> xi = new vector<float>();
	//	x.push_back(new vector<float>);
	//}


	//for (int i = 0; i < dataSize; i++)
	//{
	//	x[i] = new double[featureSize];
	//}


	myfile.close();
	myfile.open(filename);


	//int findex = 0;
	//int dindex = 0;
	while (getline(myfile, str))
	{

		//findex = 0;

		vector<double> xi;

		while ((startpos=str.find(' ', 0))!=-1)
		{
			string feature = str.substr(0, startpos);
			//x[dindex][findex] = atof(feature.c_str());
			xi.push_back(atof(feature.c_str()));
			str = str.substr(startpos+1);
			//findex++;
		}
		y.push_back(atof(str.c_str()));
		//y[dindex] = atof(str.c_str());


		//dindex++;
		x.push_back(xi);
	}
	//this->dataSize = dataSize;
	//this->featureSize = featureSize;
}

//int niuwaCART::niuwaCompare(const void*a, const void*b)
//{
//	return this->x[*(int*)a][sortindex] - this->x[*(int*)b][sortindex];
//}



void niuwaCART::constrcutNode(node * cn, vector<int> & dataIndex, const vector<vector<double>>& x, const vector<double>& y,int high )
{

	int indexSize = dataIndex.size();
	bool yflag = true;//所有Y都相同
	bool xflag = true;//所有X都相同
	bool highEnough = false;

	if (this->treeHeight!=-1&&high == this->treeHeight)//树高-1为没有限制
	{
		highEnough = true;
	}


	for (int i = 0; i < indexSize-1; i++)
	{
		if (!this->doubleEqu(y[dataIndex[i]],y[dataIndex[i + 1]]))
		{
			yflag = false;
			break;
		}
	}
	if (yflag)
	{
		cn->left = NULL;
		cn->right = NULL;
		cn->theta = y[dataIndex[0]];
		//cout << "all y equal" <<endl;
		return;
	}

	for (int i = 0; i < indexSize - 1; i++)
	{
		for (int j = 0; j < this->featureSize; j++)
		{
			if (!this->doubleEqu(x[dataIndex[i]][j], x[dataIndex[i + 1]][j]))
			{
				xflag = false;
				break;
			}
		}
		if (!xflag)
		{
			break;
		}
	}
	if (xflag||highEnough)
	{
		cn->left = NULL;
		cn->right = NULL;
		int yn = 0;
		for (int i = 0; i < indexSize; i++)
		{
			if (y[dataIndex[i]] == 1)
			{
				yn++;
			}
		}
		if (yn > indexSize / 2)
		{
			cn->theta = 1;
		}
		else
		{
			cn->theta = -1;
		}
		//cout << "all y equal" << endl;
		return;
	}





	double bestImpur = indexSize;


	for (int i = 0; i < this->featureSize; i++)
	{
		double lImpur = 0;
		double rImpur = 0;
		int * lYcount = new int[this->ycate];
		int * rYcount = new int[this->ycate];
		//this->sortindex = i;
		this->QuickSort(dataIndex, 0,indexSize-1,i,x);
	/*	for (int l = 0; l < indexSize; l++)
			cout << this->x[dataIndex[l]][i] << "  "<< dataIndex[l] <<endl;*/

		//qsort(dataIndex, indexSize, sizeof(int),  this->niuwaCompare);
		
		lYcount[0] = 0;
		lYcount[1] = 0;
		rYcount[0] = 0;
		rYcount[1] = 0;
		
		for (int j = 0; j < indexSize; j++)
		{
			if (this->doubleEqu(y[dataIndex[j]],-1.0))
			{
				rYcount[0]++;
			}
			else if(this->doubleEqu(y[dataIndex[j]],1.0))
			{
				rYcount[1]++;
			}
		}

		double curImpur = this->binImpur(lYcount, rYcount);
		if (bestImpur > curImpur)
		{
			bestImpur = curImpur;
			cn->i = i;
			cn->s = 1;
			cn->theta = x[dataIndex[0]][cn->i];
		}

		double lastfea = x[dataIndex[0]][i];
		
		
		for (int j = 1; j < indexSize; j++)
		{
			double curfea = x[dataIndex[j]][i];
			if (this->doubleEqu(y[dataIndex[j-1]],-1.0))
			{
				lYcount[0]++;
				rYcount[0]--;
			}
			else if (this->doubleEqu(y[dataIndex[j-1]], 1.0))
			{
				lYcount[1]++;
				rYcount[1]--;
			}

			if (!this->doubleEqu(lastfea, curfea))
			{
				curImpur = this->binImpur(lYcount, rYcount);
				if (bestImpur > curImpur)
				{
					bestImpur = curImpur;
					cn->i = i;
					cn->s = 1;
					cn->theta = x[dataIndex[j]][cn->i];
				}
				lastfea = curfea;
			}
		}

	}
	
	//this->sortindex = cn->i;
	//qsort(dataIndex, indexSize, sizeof(int), this->niuwaCompare);
	this->QuickSort(dataIndex, 0, indexSize-1, cn->i,x);
	int dataSum = 0;
	for (int i = 0; i < indexSize; i++)
	{
		if (x[dataIndex[i]][cn->i] < cn->theta)
		{
			dataSum++;
		}
		else
		{
			break;
		}
	}

	vector<int>  leftIndex;
	vector<int>  rightIndex;

	for (int i = 0; i < dataSum; i++)
	{
		leftIndex.push_back(dataIndex[i]);
	}

	for (int i = dataSum; i < indexSize; i++)
	{
		rightIndex.push_back(dataIndex[i]);
	}

	cn->left = new node;
	cn->right = new node;
	this->constrcutNode(cn->left, leftIndex,x,y,high+1);
	this->constrcutNode(cn->right, rightIndex, x,y,high+1);

	this->branch++;


}


void niuwaCART::train(const vector<vector<double>>& x, const vector<double>& y)
{
	this->featureSize = x[0].size();
	this->dataSize = x.size();
	root = new node;
	vector<int> index;
	for (int i = 0; i < this->dataSize; i++)
	{
		index.push_back(i);
	}
	this->constrcutNode(root,index, x, y,1);
	this->trained = true;

}


vector<double> niuwaCART::predict(vector<vector<double>> x)
{
	if (!this->trained)
		exit(0);

	vector<double> y;
	for (int i = 0; i < x.size(); i++)
	{
		y.push_back(routingFromNode(this->root,x[i]));
	}

	return y;
}



double niuwaCART::errRate(vector<double>a, vector<double>b)
{
	
	if (a.size() != b.size())
		exit(0);
	double errNum = 0;
	for (int i = 0; i < a.size();i++)
	{
		if (!niuwaCART::doubleEqu(a[i], b[i]))
		{
			errNum++;
		}
	}

	return double(errNum / double(a.size()));
}
double niuwaCART::routingFromNode(node * cn, vector<double> x)
{
	if (cn->left == NULL&&cn->right == NULL)
	{
		return cn->theta;
	}
	else
	{
		if (x[cn->i] < cn->theta)
		{
			return this->routingFromNode(cn->left, x);
		}
		else
		{
			return this->routingFromNode(cn->right, x);
		}
	}


}

bool niuwaCART::doubleEqu(double a, double b)
{
	double min = a - b;
	if (min > -0.0000001&&min < 0.0000001)
	{
		return true;
	}
	else
	{
		return false;
	}
}

double niuwaCART::binImpur(int * lYcount, int * rYcount)
{
	double lImpur, rImpur;
	double n = lYcount[0] + lYcount[1];
	if (this->doubleEqu(n,0.0))
	{
		lImpur = 0;
	}
	else
	{
		lImpur = n*(1 - ((lYcount[0] / n)*(lYcount[0] / n) + (lYcount[1] / n)*(lYcount[1] / n)));
	}
	n = rYcount[0] + rYcount[1];
	if (this->doubleEqu(n, 0.0))
	{
		rImpur = 0;
	}
	else
	{
		rImpur = n*(1 - ((rYcount[0] / n)*(rYcount[0] / n) + (rYcount[1] / n)*(rYcount[1] / n)));
	}

	return  lImpur + rImpur;
}


void niuwaCART::QuickSort(vector<int> & e, int first, int end,int featureIndex, const vector<vector<double>>& x)
{
	
	int i = first, j = end;
	//int temp = e[first];//记录第一个数据  
	double temp = x[e[first]][featureIndex];
	while (i<j)
	{
		while (i<j && x[e[j]][featureIndex] >= temp)  //与first数据比较，右边下标逐渐左移  
			j--;

		

		while (i<j &&  x[e[i]][featureIndex] <= temp)  //与first数据比较，左边下标逐渐右移  
			i++;

		int a = e[j];
		e[j] = e[i];
		e[i] = a;

	}
	int a = e[i];
	e[i] = e[first];                      //将first数据放置于i=j处  
	e[first] = a;
	if (first<i - 1)
		QuickSort(e, first, i - 1, featureIndex,x);
	if (end>i + 1)
		QuickSort(e, i + 1, end, featureIndex,x);
}



niuwaCART::~niuwaCART()
{
}
