module graphics.shaders;

import derelict.opengl;

class Shaders {
  public enum Vertex {
    FULLSCREEN = 0,
    NORMAL_TILE = 1,
  };

  public enum Fragment {
    SINGLE_TILE = 0,
    MULTI_TILE = 1,
    SHADOW_TILE = 2,
  };
  
  public static ref Shaders get() {
    if(b_Running)
      synchronized(Shaders.classInfo) {
        if(!c_Instance)
          c_Instance = new Shaders();
        b_Running = true;
      }
    return c_Instance;
  };
  
  public uint vertex(uint uIndex) const { return uv_vertexShaders[uIndex]; };
  
  public uint fragment(uint uIndex) const { return uv_fragmentShaders[uIndex]; };
  
  private static Shaders c_Instance;
  private static bool b_Running;
  
  private immutable uint uv_vertexShaders[2];
  private immutable uint uv_fragmentShaders[3];
  private this() {
    string svVertexSource[2] = {
      "#version 330 core\n"
      "in vec4 xy_uv;"
      "out vec2 uv;"
      "void main() {"
      ""
      "uv = xy_uv.zw;"
      "}",

      "#version 330 core\n"
      "in vec4 xy_uv;"
      "out vec2 uv;"
      "void main() {"
      ""
      "uv = xy_uv.zw;"
      "}"
    };
    for(uint i = 0; i < 2; ++i) {
      uv_vertexShaders[i] = glCreateShader(GL_VERTEX_SHADER);
      glShaderSource(uv_vertexShaders[i], 1, svVertexSource[i], null);
      glCompileShader(uv_vertexShaders[i]);
    }
    
    string svFragmentSource[3] = {
      "#version 330 core\n"
      "in vec2 uv;"
      "out vec4 colour;"
      "void main() {"
      ""
      "}",
      
      "#version 330 core\n"
      "in vec2 uv;"
      "out vec4 colour;"
      "void main() {"
      ""
      "}",
      
      "#version 330 core\n"
      "in vec2 uv;"
      "out vec4 colour;"
      "void main() {"
      ""
      "}",
    };
    for(uint i = 0; i < 2; ++i) {
      uv_fragmentShaders[i] = glCreateShader(GL_FRAGMENT_SHADER);
      glShaderSource(uv_fragmentShaders[i], 1, svFragmentSource[i], null);
      glCompileShader(uv_fragmentShaders[i]);
    }
  };

  private ~this() {
    foreach(shader; uv_vertexShaders) {
      glDeleteShader(shader);
    }
    foreach(shader; uv_fragmentShaders) {
      glDeleteShader(shader);
    }
  };
};
