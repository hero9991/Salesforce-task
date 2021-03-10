/**
 * Created by a000 on 06.03.2021.
 */

trigger checkTrigger on Account (before insert) {
    if(checkClass.num == 1) {
        checkClass.num = 2;
        for(Account accountItem : Trigger.new){
            accountItem.Description = 'Trigger worked on this account';
        }
    }
}