{if count($aTopics)>0}	
	{foreach from=$aTopics item=oTopic}    
			<!-- Topic -->			
			<div class="topic">
				<!--
				<div class="favorite {if $oUserCurrent}{if $bInFavourite}active{/if}{else}guest{/if}"><a href="#" onclick="lsFavourite.toggle({$oTopic->getId()},this,'topic'); return false;"></a></div>
				-->
				<h1 class="title">					
					<a href="{if $oTopic->getType()=='link'}{$DIR_WEB_ROOT}/{$ROUTE_PAGE_LINK}/go/{$oTopic->getId()}/{else}{$oTopic->getUrl()}{/if}">{$oTopic->getTitle()|escape:'html'}</a>
					{if $oTopic->getType()=='link'}
  						<img src="{$DIR_STATIC_SKIN}/images/link_url_big.gif" border="0" title="{$aLang.topic_link}" width="16" height="16" alt="{$aLang.topic_link}">
  					{/if}
				</h1>
				<ul class="action">
					<li><a href="{$oTopic->getBlogUrlFull()}">{$oTopic->getBlogTitle()|escape:'html'}</a>&nbsp;&nbsp;</li>
					<li class="rss"><a href="#" onclick="return false;"></a></li>
					<li class="plus"><a href="#" onclick="return false;"></a></li>
					<li class="join"><a href="#" onclick="return false;"></a></li>
				</ul>				
				<div class="content">
				
			{if $oTopic->getType()=='question'}   
    		
    		<div id="topic_question_area_{$oTopic->getId()}">
    		{if !$oTopic->getUserQuestionIsVote()} 		
    			<ul class="poll-new">	
				{foreach from=$oTopic->getQuestionAnswers() key=key item=aAnswer}				
					<li><label for="topic_answer_{$oTopic->getId()}_{$key}"><input type="radio" id="topic_answer_{$oTopic->getId()}_{$key}" name="topic_answer_{$oTopic->getId()}"  value="{$key}" onchange="$('topic_answer_{$oTopic->getId()}_value').setProperty('value',this.value);"/> {$aAnswer.text}</label></li>				
				{/foreach}
					<li>
					<input type="submit"  value="{$aLang.topic_question_vote}" onclick="ajaxQuestionVote({$oTopic->getId()},$('topic_answer_{$oTopic->getId()}_value').getProperty('value'));">
					<input type="submit"  value="{$aLang.topic_question_abstain}"  onclick="ajaxQuestionVote({$oTopic->getId()},-1)">
					</li>				
					<input type="hidden" id="topic_answer_{$oTopic->getId()}_value" value="-1">				
				</ul>				
				<span>{$aLang.topic_question_vote_result}: {$oTopic->getQuestionCountVote()}. {$aLang.topic_question_abstain_result}: {$oTopic->getQuestionCountVoteAbstain()}</span><br>			
			{else}			
				{include file='topic_question.tpl'}
			{/if}
			</div>
			<br>	
						
    		{/if}
				
					{$oTopic->getTextShort()}
					{if $oTopic->getTextShort()!=$oTopic->getText()}
      					<br><br>( <a href="{$oTopic->getUrl()}" title="{$aLang.topic_read_more}">
      					{if $oTopic->getCutText()}
      						{$oTopic->getCutText()}
      					{else}
      						{$aLang.topic_read_more}
      					{/if}      			
      					</a> )
      				{/if}
				</div>				
				<ul class="tags">
					{$oTopic->getTagsLinkNew()}										
				</ul>				
				<ul class="voting {if $oTopic->getUserIsVote() || ($oUserCurrent && $oTopic->getUserId()==$oUserCurrent->getId())}{if $oTopic->getRating()>0}positive{elseif $oTopic->getRating()<0}negative{/if}{/if} {if !$oUserCurrent || $oTopic->getUserId()==$oUserCurrent->getId()}guest{/if} {if $oTopic->getUserIsVote()} voted {if $oTopic->getUserVoteDelta()>0}plus{elseif $oTopic->getUserVoteDelta()<0}minus{/if}{/if}">
					<li class="plus"><a href="#" onclick="lsVote.vote({$oTopic->getId()},this,1,'topic'); return false;"></a></li>
					<li class="total">{if $oTopic->getUserIsVote() || ($oUserCurrent && $oTopic->getUserId()==$oUserCurrent->getId())} {$oTopic->getRating()} {else} <a href="#" onclick="lsVote.vote({$oTopic->getId()},this,0,'topic'); return false;">&mdash;</a> {/if}</li>
					<li class="minus"><a href="#" onclick="lsVote.vote({$oTopic->getId()},this,-1,'topic'); return false;"></a></li>
					<li class="date">{date_format date=$oTopic->getDateAdd()}</li>
					{if $oTopic->getType()=='link'}
						<li class="link"><a href="{$DIR_WEB_ROOT}/link/go/{$oTopic->getId()}/" title="{$aLang.topic_link_count_jump}: {$oTopic->getLinkCountJump()}">{$oTopic->getLinkUrl(true)}</a></li>						
					{/if}					
					<li class="author"><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_PROFILE}/{$oTopic->getUserLogin()}/">{$oTopic->getUserLogin()}</a></li>		
					<li class="comments-total">
						{if $oTopic->getCountComment()>0}
							<a href="{$DIR_WEB_ROOT}/blog/{if $oTopic->getBlogUrl()}{$oTopic->getBlogUrl()}/{/if}{$oTopic->getId()}.html#comments" title="{$aLang.topic_comment_read}"><span class="red">{$oTopic->getCountComment()}{if $oTopic->getCountCommentNew()}</span><span class="green">+{$oTopic->getCountCommentNew()}</span>{/if}</a>
						{else}
							<a href="{$DIR_WEB_ROOT}/blog/{if $oTopic->getBlogUrl()}{$oTopic->getBlogUrl()}/{/if}{$oTopic->getId()}.html#comments" title="{$aLang.topic_comment_add}"><span class="red">{$aLang.topic_comment_add}</span></a>
						{/if}
					</li>			
				</ul>
			</div>
			<!-- /Topic -->
	{/foreach}	
		
    {include file='paging.tpl' aPaging=`$aPaging`}			
	
{else}
{$aLang.blog_no_topic}
{/if}