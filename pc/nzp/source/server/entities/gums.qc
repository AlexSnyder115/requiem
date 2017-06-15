void() StockOption =
{
	local float revert;
	gum_stock = 1;
	revert = 60 + time;
	if (revert < time)
	{
		gum_stock = 0;
		return;
	}
}
void() RoundRobbin =
{
	NewRound();
}