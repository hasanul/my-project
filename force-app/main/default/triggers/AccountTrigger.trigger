trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    	
	if(trigger.isupdate) {
		if(trigger.isafter) {
        		AccountTriggerHandler.updateContactState(Trigger.new, Trigger.oldMap);
		}
	}
}
