{include file='header.tpl' showWhiteBack=true menu='people'}

			<div class="page people">
				
				<h1>Недавно были на сайте</h1>
				
				{if $aUsersLast}
				<table>
					<thead>
						<tr>
							<td class="user">Пользователь</td>													
							<td class="date">Последний визит</td>
							<td class="strength">Сила</td>
							<td class="rating">Рейтинг</td>
						</tr>
					</thead>
					
					<tbody>
					{foreach from=$aUsersLast item=oUser}
						<tr>
							<td class="user"><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_PROFILE}/{$oUser->getLogin()}/"><img src="{$oUser->getProfileAvatarPath(24)}" alt="" /></a><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_PROFILE}/{$oUser->getLogin()}/" class="link">{$oUser->getLogin()}</a></td>														
							<td class="date">{date_format date=$oUser->getDateLast()}</td>
							<td class="strength">{$oUser->getSkill()}</td>							
							<td class="rating"><strong>{$oUser->getRating()}</strong></td>
						</tr>
					{/foreach}						
					</tbody>
				</table>
				{else}
					нет таких	
				{/if}
			</div>

			{include file='paging.tpl' aPaging=`$aPaging`}
			
			
{include file='footer.tpl'}