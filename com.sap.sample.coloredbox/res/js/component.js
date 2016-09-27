define(["sap/designstudio/sdk/component","css!../css/component.css","./socket"], function(Component, css,io) {
	Component.subclass("com.sap.sample.coloredbox.ColoredBox", function() {

		var that = this;
		var this_dashboardinfo='sample;working;fine';
		var this_maxmininfo='Product A has the highest Revenue and Product B has the lowest Revenue;Region A has the highest profit and Region B has the lowest Profit.';
		var socket;

		this.init = function() {			
			this.$().hide();
			this.$().click(function() {
				that.fireEvent("onclick");
			});
		
			this.$().append('<div id="messages"/>');
			
			socket = io.connect('https://alexavbi.herokuapp.com');
			socket.on('open', function(msg){
				console.log('app opened');
		      });
			socket.on('filter',function(data){
				var dimCon=data.split(':')
				console.log(dimCon);
				if(dimCon[0]=='country'){
					that.callZTLFunction('filterDim', function(value) {
					},dimCon[0],dimCon[1]);
				}else{
					that.callZTLFunction('filterDim1', function(value) {
						//	alert(value);
						},dimCon[0],dimCon[1]);
				}
			});
			socket.on('measure',function(data){
				var mesFac=data.split(':')
				that.callZTLFunction('opennewMeasure', function(value) {
					//	alert(value);
					},mesFac[0],mesFac[1]);
			});
			  
		};
		
		this.afterUpdate=function(){
			   socket.emit('userdashboardinfo', this_dashboardinfo);
			   socket.emit('maxmininfo', this_maxmininfo);
		};
		
		this.color = function(value) {
			if (value === undefined) {
				return this.$().css("background-color");
			} else {
				this.$().css("background-color", value);
				return this;
			}
		};
		
		this.dashboardinfo=function(value){
			if (value === undefined) {
				return this_dashboardinfo;
			} else {
				this_dashboardinfo=value;
				return this_dashboardinfo;
			}
		}
		
		this.maxmininfo=function(value){
			if (value === undefined) {
				return this_maxmininfo;
			} else {
				this_maxmininfo=value;
				return this_maxmininfo;
			}
		}
		
	});	
});
    
