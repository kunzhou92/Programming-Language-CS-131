import java.util.concurrent.atomic.AtomicIntegerArray;
class GetNSetState implements State {
    private AtomicIntegerArray value;
    private byte maxval;

    GetNSetState(byte[] v)
    {
        int length = v.length;
        value = new AtomicIntegerArray(length);
        for(int i=0; i < length; i++)
            value.set(i, v[i]);
        maxval = 127;
    }

    GetNSetState(byte[] v, byte m)
    {
        int length = v.length;
        value = new AtomicIntegerArray(length);
        for(int i=0; i < length; i++)
            value.set(i, v[i]);
        maxval = m;
     }

    public int size() { return value.length(); }

    public byte[] current()
    {
        int length = value.length();
        byte[] currentV = new byte[length];
        for(int i=0; i < length; i++)
            currentV[i] = (byte)value.get(i);
        return currentV;
    }

    public boolean swap(int i, int j) {
	if (value.get(i) <= 0 || value.get(j) >= maxval) {
	    return false;
	}
  value.decrementAndGet(i);
  value.incrementAndGet(j);
	return true;
    }
}
