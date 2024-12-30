var nameArr, allDone, cCount, catLast, len, i, _ob;

nameArr = creditEntries[currentCategory][1];
allDone = true;
cCount = -1;
catLast = false;
len = array_length(nameArr);

for (i = 0; i < len; i++)
{
    _ob = nameArr[i];
    
    if (_ob.active || !_ob.activated)
        allDone = false;
    
    if (_ob.activated && _ob.index > cCount)
        cCount = _ob.index;
    
    if (_ob.activated && i == (len - 1))
        catLast = true;
}

if (!allDone && cCount == currentCredit && !catLast)
{
    currentCredit++;
}
else if (allDone)
{
    currentCategory++;
    currentCredit++;
}
else
{
    alarm[0] = 2;
}
