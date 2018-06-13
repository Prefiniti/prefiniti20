/*
 * RealTimeEvents.js
 *  Realtime Events handling and the scheduler
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008, AJL Intel-Properties LLC 
 */


// task priorities
var TP_LOW				= 0;
var TP_NORMAL 			= TP_LOW;
var TP_MEDIUM			= 1;
var TP_HIGH 			= 2;
 
var TotalCycles = 0;

var PTasks = new Array(1);
var TaskID = 0;

function ClearTasks () 
{
	for (i in PTasks) {
		window.clearInterval(PTasks[i].TimerID);
	}
	
	PTasks = new Array(1);
	TaskID = 0;
}

function PTask (TaskName, TaskFunction, Priority, Enabled, Owner, PausedFunction) {
	this.TaskName = TaskName;
	this.TaskFunction = TaskFunction;
	this.PausedFunction = PausedFunction;
	this.Priority = Priority;
	this.Enabled = Enabled;
	this.Owner = Owner;
	this.RunCount = 0;
	this.TID = null;
	this.TimerID = null;
}

PTask.prototype.Pause = function () {
	this.Enabled = false;
	
	if(this.PausedFunction) {
		this.PausedFunction();
	}
	
	var sr = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(sr, '<font color="red">Pause</font>');
	
	
};

PTask.prototype.Resume = function () {
	this.Enabled = true;
	
	var sr = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(sr, '<font color="orange">Wait</font>');
	
};

PTask.prototype.Run = function () {
	if(this.Enabled) {
	TotalCycles++;
	tsRef = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(tsRef, '<font color="green">Run</font>');
	
	this.TaskFunction();
	this.RunCount++;
	SetInnerHTML(tsRef, '<font color="orange">Wait</font>');
	tsRef = 'TaskRC_' + this.TID.toString();
	SetInnerHTML(tsRef, this.RunCount.toString());
	tsRef = 'TaskPercent_' + this.TID.toString();
	taskPercent = parseInt((this.RunCount * 100) / (TotalCycles));
	SetInnerHTML(tsRef, taskPercent + "%");
	}
};

function PAddTask(Task) {
	PTasks[TaskID] = Task;
	PTasks[TaskID].TID = TaskID;
	PTasks[TaskID].Run();
	
	fcn = "PTasks[" + TaskID + "].Run();"
	PTasks[TaskID].TimerID = window.setInterval(fcn, PTasks[TaskID].Priority * 1000);
	
	TaskID++;
	
	return (TaskID - 1);
}

function PauseAllTasks() {
	for (i in PTasks) {
		if (PTasks[i].Owner == AuthenticationRecord.UserID) {
			PTasks[i].Pause();
		}
	}
}

function ResumeAllTasks() {
	for (i in PTasks) {
		PTasks[i].Resume();
	}
}

function PMaxWait()
{
	var LastWait = 1;
	var MaxWait = 0;
	
	for (i in PTasks)
	{
		LastWait = PTasks[i].Priority;
		if (LastWait > MaxWait) {
			MaxWait = LastWait;
		}
	}
	
	return MaxWait;
}




function PEnableTaskQueue ()
{
	
}

function PAutoUpdater(ResourceURL, TargetDiv)
{
	var udf = function() {
		AjaxSilentLoad(TargetDiv, ResourceURL);
	};
	
	return udf;
}	

