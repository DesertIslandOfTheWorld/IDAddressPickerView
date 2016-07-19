# IDAddressPickerView
省市区三级联动的 PickerView

##像这样来使用

- 提供数据源

	```
	#pragma mark - IDAddressPickerViewDataSource
	- (NSArray *)addressArray {
	   // 地址信息
	}
	```
	
- 获取选中的地址

	```
	/**
	 *  所选中的 省市区 信息，分别对应于 key: province, city, area
	 */
	@property (nonatomic, strong) NSMutableDictionary *selectedAddress;
	```
	
####就是这么简单

- 若要了解其细节，请浏览博客：[世俗孤岛](http://www.cnblogs.com/theDesertIslandOutOfTheWorld/p/5683025.html)