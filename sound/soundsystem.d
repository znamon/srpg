module sound.soundsystem;

class SoundSystem {
  public static SoundSystem get() {
    if(!b_Running)
      synchronized(SoundSystem.classInfo)
      {
        if(!c_Instance)
          c_Instance = new SoundSystem();
        b_Running = true;
      }
    return c_Instance;
  };

  public static void destroy() {
    if(b_Running)
      synchronized(SoundSystem.classInfo)
      {
        delete c_Instance;
        b_Running = false;
      }
  };
  
  private static __gshared SoundSystem c_Instance;

  private this() {};
   
  private ~this() {};
};
