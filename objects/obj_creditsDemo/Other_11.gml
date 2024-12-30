var n, _nameArr, i, _ob;

if (currentCategory < 0)
{
    currentCredit = 0;
    currentCategory = 0;
}
else if (currentCategory >= categoryCount)
{
    fadein = true;
}
else
{
    for (n = 0; n < array_length(creditEntries); n++)
    {
        _nameArr = creditEntries[n][1];
        
        for (i = 0; i < array_length(_nameArr); i++)
        {
            _ob = _nameArr[i];
            
            if (!_ob.active && currentCredit != _ob.index)
                continue;
            else if (!_ob.active && !_ob.activated && n == currentCategory)
                _ob.activate();
            
            _ob.hsp = creditsSpeed;
            _ob.step();
        }
    }
}
