with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_Io; use Text_IO;

with Mckae.Xml.Ez_Out.Generic_Medium;
with Mckae.Xml.Ez_Out.Text_File;
use  Mckae.Xml.Ez_Out.Text_File;
with Mckae.XML.Ez_Out.String_Stream;

procedure Tmeztf is

   use Mckae.Xml.Ez_Out;
   use String_Stream;
   use XML_String_Buffer;

   package Ezcs is new Mckae.Xml.Ez_Out.Generic_Medium
     (File_Type, Put, New_Line, Continuous_Stream);
   use Ezcs;

   package Ezsi is new Mckae.Xml.Ez_Out.Generic_Medium
     (File_Type, Put, New_Line, Spread_Indented);
   use Ezsi;

   State : Unbounded_String := To_Unbounded_String("state");
   Zip   : Unbounded_String := To_Unbounded_String("zipcode");
   MN    : Unbounded_String := To_Unbounded_String("MN");
   Bud   : Unbounded_String := To_Unbounded_String("Bud");

   Ss : Mckae.Xml.Ez_Out.String_Stream.String_Buffer (500, 500);

begin
   Put_Line("Continuous Stream:");
   New_Line;

   Ezcs.Output_Xml_Header(Standard_Output);
   Ezcs.Output_Processing_Instruction(Standard_Output,
                                      "stylesheet", "bob.xsl");
   Ezcs.Start_Element(Standard_Output,
                      "parent",
                      "name" = "jones");
   Ezcs.Output_Tag(Standard_Output,
                   "child",
                   ("name" = "jane",
                    "sex"  = 'F',
                    "age" = 7,
                    "height"=54.7));
   Ezcs.Output_Tag(Standard_Output,
                   "child",
                   ("name" = "Tom",
                    "sex" = 'M',
                    "age" = 4,
                    "height"=44.7));
   Ezcs.Output_Tag(Standard_Output,
                   "residence",
                   (State = "AL", Zip = 35806, "temp" = -2));
   Ezcs.Output_Element(Standard_Output,
                       "child",
                       "Third and last",
                       ("name" = "Tom",
                        "age" = 1,
                        "height"=24.7));
   Ezcs.End_Element(Standard_Output, "parent");
   New_Line(2);

   Put_Line("Indented:");
   New_Line;
   Ezsi.Output_Xml_Header(Standard_Output);
   Ezsi.Output_Processing_Instruction(Standard_Output,
                                      "stylesheet", "bob.xsl");
   Ezsi.Output_Tag(Standard_Output, "fred",
                   (("tom" = "harry"),
                    ("mike" = 32)));

   Ezsi.Start_Element(Standard_Output,
                      "parent",
                      "name" = "jones");
   Ezsi.Output_Tag(Standard_Output,
                   "child",
                   ("name" = "jane",
                    "age" = 7,
                    "height"=54.7));
   Ezsi.Output_Tag(Standard_Output,
                   "child",
                   ("name" = "Tom",
                    "age" = 4,
                    "height"=44.7));
   Ezsi.Output_Tag(Standard_Output,
                   "associate",
                   "name" = Bud);
   Ezsi.Start_Element(Standard_Output,
                       "child",
                       ("name" = "Tom",
                        "age" = 1,
                        "height"=24.7));
   Ezsi.Output_Content(Standard_Output, "Keeping up <with> the Joneses");
   Ezsi.End_Element(Standard_Output);
   Ezsi.End_Element(Standard_Output, "parent");
   New_Line;


   Put_Line("Text File output:");
   New_Line;
   Text_File.Output_Xml_Header(Standard_Output);
   Text_File.Output_Processing_Instruction(Standard_Output,
                                           "stylesheet", "bob.xsl");
   Text_File.Start_Element(Standard_Output,
                           "parent",
                           "name" = "jones");
   Text_File.Output_Tag(Standard_Output,
                        "child",
                        ("name" = "jane",
                         "age" = 7,
                         "height"=54.7));
   Text_File.Output_Tag(Standard_Output,
                        "child",
                        ("name" = "Tom",
                         "age" = 4,
                         "height"=44.7));
   Text_File.Output_Element(Standard_Output,
                            "child",
                            "Third",
                            ("name" = "Tom",
                             "age" = 1,
                             "height"=24.7));
   Text_File.Output_Element(Standard_Output,
                            "child",
                            "Fourth & last",
                            ("name" = "Tom",
                             "age" = 1,
                             "height"=24.7));
   Text_File.Output_Tag(Standard_Output, "fred",
                        (("tom" = "harry"),
                         ("mike" = 32)));
   Text_File.Output_Tag(Standard_Output,
                        "residence",
                        (State = "", Zip = 55067));

   -- Change the setting for outputting null-valued attributes.
   Text_File.Default_Output_Null_Attributes := True;
   Text_File.Output_Tag(Standard_Output,
                        "undercover",
                        (State = "", Zip = 55067));
   Text_File.End_Element(Standard_Output, "parent");

   New_Line(2);

   Put_Line("String stream output:");
   New_Line;
   Xml_String_Buffer.Output_Xml_Header(Ss);
   Xml_String_Buffer.Output_Processing_Instruction(Ss,
                                           "stylesheet", "bob.xsl");
   Xml_String_Buffer.Start_Element(Ss,
                           "parent",
                           "name" = "jones");
   Xml_String_Buffer.Output_Tag(Ss,
                        "child",
                        ("name" = "jane",
                         "age" = 7,
                         "height"=54.7));
   Xml_String_Buffer.Output_Tag(Ss,
                        "child",
                        ("name" = "Tom",
                         "age" = 4,
                         "height"=44.7));
   Xml_String_Buffer.Output_Element(Ss,
                            "child",
                            "Third and last",
                            ("name" = "Tom",
                             "age" = 1,
                             "height"=24.7));
   Xml_String_Buffer.Output_Tag(Ss, "fred",
                        (("tom" = "harry"),
                         ("mike" = 32)));
   Xml_String_Buffer.End_Element(Ss, "parent");

   Put_Line(String_Stream.Get_String(Ss));

end Tmeztf;
