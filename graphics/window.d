module graphics.window;

import derelict.glfw3;

class Window {
  public static ref Window get() {
    if(!b_Running)
      synchronized(Window.classInfo)
      {
        if(!c_Instance)
          c_Instance = new Window();
        b_Running = true;
      }
    return c_Instance;
  };
  
  public static void destroy() {
    if(b_Running)
      synchronized(Window.classInfo)
      {
        delete c_Instance;
        b_Running = false;
      }
  };
  
  private static __gshared Window c_Instance;
  
  private this() {
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    sp_Window = glfwCreateWindow(x = 640, y = 400, "", null, null);
    if(sp_Window == null)
      throw Throwable("Failed to init window");
    glfwMakeContextCurrent(sp_Window);
    glfwSwapInterval(1);
  };
  
  private ~this() {
    glfwDestroyWindow(sp_Window);
  };
  
  GLFWwindow* sp_Window;
  bool b_Running = false;
  uint u_x, u_y;
};
