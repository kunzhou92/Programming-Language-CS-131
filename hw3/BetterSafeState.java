import java.util.concurrent.locks.*;
class BetterSafeState implements State
{
  private byte[] value;
  private byte maxval;
  private Lock mylock;

  BetterSafeState(byte[] v)
  {
        value = v;
        maxval = 127;
        mylock = new ReentrantLock();
  }

  BetterSafeState(byte[] v, byte m)
  {
        value = v;
        maxval = m;
        mylock = new ReentrantLock();
  }

  public int size()
  {
        return value.length;
  }

  public byte[] current()
  {
        return value;
  }

  public boolean swap(int i, int j)
  {
      mylock.lock();
      while (value[i] <= 0 || value[j] >= maxval)
      {
        mylock.unlock();
        return false;
      }
      value[i]--;
      value[j]++;
      mylock.unlock();
      return true;
  }
}
