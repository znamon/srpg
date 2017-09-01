module graphics.gl_obj;

import derelict.opengl;
import graphics.shaders;

class GL_Obj {
  public this(float fSizeX, float fSizeY, Shaders.Vertex uVertexIndex, Shaders.Fragment uFragmentIndex) {
    glGenVertexArrays(1, u_vao);
    glBindVertexArray(u_vao);
    
    immutable float fvCoords[] = {
      0.f, 0.f,
      0.f, fSizeY,
      fSizeX, fSizeY,
      fSizeX, 0.f
    };
    glGenBuffers(1, u_vbo);
    glBindBuffer(u_vbo);
    glBufferData(GL_ARRAY_BUFFER, fvCoords.sizeof, fvCoords, GL_STATIC_DRAW);

    u_prog = glCreateProgram();
    Shaders cShaders = Shaders.get();
    
    uint uVertex = cShaders.vertex(uVertexIndex);
    glAttachShader(u_prog, uVertex);
    
    uint uFragment = cShaders.fragment(uFragmentIndex);
    glAttachShader(u_prog, uFragment);
    
    glLinkProgram(u_prog);
    
    glDetachShader(u_prog, uVertex);
    glDetachShader(u_prog, uFragment);
	/* Check if successful */
  };
  
  public ~this() {
    glDeleteVertexArrays(1, u_vao);
    glDeleteBuffers(1, u_vbo);
    glDeleteProgram(u_prog);
  };
  
  public void load() const {
    glBindVertexArray(u_vao);
    glBindBuffer(GL_ARRAY_BUFFER, u_vbo);
    glUseProgram(u_prog);
  };
  
  public void print() const {
    load();
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  };
  
  public static void unload() const {
    glBindVertexArray(-1);
    glBindBuffer(GL_ARRAY_BUFFER, -1);
    glUseProgram(-1);
  };
  
  private immutable uint u_vao, u_vbo, u_prog;
};
