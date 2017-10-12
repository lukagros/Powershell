function EnableDisableOutofOffice
{
PARAM (
$TurnOffOnOOO,
$ForUser,
$InternalMessage,
$externalMessage,
$ScheduledOOO,
$DateBegin,
$DateEnd
)

$Credentials = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://(URI)/PowerShell/ -Credential $Credentials -Authentication Kerberos –AllowRedirection -Name 'SetupAutomaticreply-Custom'#Name is custom
Import-PSSession $Session

$InternalMessage = "<html><head></head><body><p style=""font-family: Arial;font-size: 10pt;"">Dear all,</br>I'm currently out of office.</br>Best Regards</p></body></html>" 
$externalMessage = "<html><head></head><body><p style=""font-family: Arial;font-size: 10pt;"">Dear all,</br>I'm currently out of office.</br>Best Regards</p></body></html>" 


if ($TurnOffOnOOO -eq '1')
        {
        if ($ScheduledOOO -eq '1')
                {
                    Set-MailboxAutoReplyConfiguration $ForUser –AutoReplyState Scheduled –StartTime $DateBegin –EndTime $DateEnd –ExternalMessage $externalMessage –InternalMessage $InternalMessage
                                    }
                else
                {
                    Set-MailboxAutoReplyConfiguration $ForUser –AutoReplyState Enabled –ExternalMessage $externalMessage –InternalMessage $InternalMessage
                }
         }#ifUpali
    else
        {
           Set-MailboxAutoReplyConfiguration $ForUser –AutoReplyState Disabled
        }#ifUgsi
#Set-MailboxAutoReplyConfiguration lgros@youremail.com –AutoReplyState Scheduled –StartTime “1/8/2013” –EndTime “1/15/2013” –ExternalMessage “Type External OOF message here” –InternalMessage “Type Internal OOF message here”


remove-pssession -Name 'SetupAutomaticreply-Custom'
}

EnableDisableOutofOffice -TurnOffOnOOO '1' -ForUser 'tatjana.savic@uniqa.hr' -ScheduledOOO '0'  -DateBegin '21/11/2016 08:00' -DateEnd '05/09/2016 07:30' -InternalMessage $InternalMessage -externalMessage $externalMessage